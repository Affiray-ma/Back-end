import { Injectable } from '@nestjs/common';
import { S3Service } from './s3.service';
import { PrismaClient } from '@prisma/client';
import { HttpService } from '@nestjs/axios';
import { faker } from '@faker-js/faker';
import * as axios from 'axios';
import { Observable, firstValueFrom } from 'rxjs';
import * as bcrypt from 'bcrypt';
import sharp from 'sharp';
@Injectable()
export class DevToolsService {
    constructor(private readonly s3Service: S3Service,
        private readonly prisma: PrismaClient,
        private readonly httpService: HttpService) {

    }

    async getMakers() {
        const makers = await this.prisma.maker.findMany({
            include: {
                image: true
            }
        })
        return makers;
    }
    async deleteMakers() {
        const makers = await this.prisma.maker.deleteMany({
        })
        return makers;
    }
    async PostMaker(data: any){
        const maker = await this.prisma.maker.create({
            data: {
                name: data.name,
            }
        })
       const image = await axios.default.get(data.image.source, { responseType: 'arraybuffer' })
        console.log(image)
        //return image;
        const buffer  = Buffer.from(image.data,'binary');
         const file = await this.s3Service.uploadBinFile(buffer,"maker/"+maker.id,
         image.headers['content-type']);
         
        const thumb = await this.prisma.thumbnails.create({
           
            data: {
                dest: "maker/"+maker.id,
                Maker: {
                    connect: {
                        id: maker.id
                    }
                }
            }
        })
        const makers = await this.prisma.maker.findUnique({
            where: {
                id: maker.id
            },
            include: {
                image: true
            }
        })
        return makers;
    }
    async CreateMachine(){
        const machine = await this.prisma.machine.create({
            data: {
                name: "Car",
            }
        })
        return machine;
    }
    async PostMaker2(data: any) {
        const maker = await this.prisma.maker.create({
            data: {
                name: data.name,
            }
        })
        return maker;
    }
    async PostModel(data:any){
        const model = await this.prisma.car_Model.create({
            data: {
                name: data.name,
                maker :{
                    connect: {
                        id: data.maker
                    }
                },
                Machine:{
                    connect: {
                        id: data.machine
                    }
                }
            }
        })
        return model;
    }
    async PostMachinePart(data:any){
        const part = await this.prisma.machine_Part.create({
            data: {
                name: data.name,
                machine:{
                    connect: {
                        id: data.machine
                    }
                },
                bg_color: "#FFFFFF",
            }
        })
        return part;
    }
    async PostCaTegory(data:any){
        const category = await this.prisma.category.create({
            data: {
                name: data.name,
                machine_part:{
                    connect: {
                        id: data.machine
                    }
                },            
            }
        })
        return category;
    }
    async deleteAll(){
        // await this.prisma.category.deleteMany({})
        // await this.prisma.car_Model.deleteMany({})
        // await this.prisma.machine_Part.deleteMany({})
        await this.prisma.maker.deleteMany({})

    }

    async mok_users() {
        const users = [];
        for (let index = 0; index < 10; index++) {
            const email = faker.internet.email();
            const user = {
                email: email,
                phone: faker.phone.number(),
                password: await bcrypt.hash(email, 10),
                name: faker.person.firstName(),
                birth_date: '1999-01-01',
                customer_rank :1,
            }

            const user_created = await this.prisma.user.create({
                data: {
                    ...user,
                    
                    image: {
                        create: {
                            dest: faker.image.avatar(),
                            
                        }
                    }
                }
            })
            users.push({user,is_created: user_created ? true : false});
        }
        return users;
    }

    async mok_products() {
        const products = [];
        for (let index = 0; index < 10; index++) {
            let random_categories = await this.prisma.category.findMany({
               
            })
            let random_category = random_categories[Math.floor(Math.random() * random_categories.length)];
            let models = await this.prisma.car_Model.findMany({})
            let random_model = models[Math.floor(Math.random() * models.length)];
            
            let images = []
            for (let index = 0; index < 5; index++) {
                let image = await this.prisma.thumbnails.create({
                   data:{
                          dest: "product/" + faker.image.avatar(),              
                   } 
                })
                images.push(image);


            }
            const product_created = await this.prisma.product.create({
                data: {
                    name: faker.commerce.productName(),
                    description: faker.commerce.productDescription(),
                    price: parseFloat(faker.commerce.price()),
                    thumbs :{
                        connect: images.map((image,index) => {
                            if(index > 0){
                                return {
                                    id: image.id,                                    
                                }
                            }               
                        })
                    },
                    default_thumb: images[0].id,
                    category: {
                        connect: {
                            id: random_category.id
                        }
                    },
                    models: {
                        connect: {
                            id: random_model.id
                        }
                    },
                    references: faker.vehicle.vin(),
                   
                }
            })
            products.push({product_created,is_created: product_created ? true : false});
        }
        return products;
    }
    async getProducts(){
        const products = await this.prisma.product.findMany({
        })
        const ret = []
        for (let index = 0; index < products.length; index++) {
            const product = products[index];
            const thumbs = await this.prisma.thumbnails.findUnique({
                where: {
                    id : products[index].default_thumb
                }
            })
            
            products[index].default_thumb = thumbs.dest;
        }
        //i need to get the default thumb of the product and encode it to base64
        
        
        
        return products;
    }
    async get_external_image(url: string,size: number) {
        
        
        //rmove all characters before http
        const key = "http" + url.split("http")[1];
        const response = await firstValueFrom(this.httpService.get(key, { responseType: 'arraybuffer' }));
        //resize the image if the size is not null
        if(size){
            const buffer = await sharp(response.data as Buffer)
            .resize(parseInt(size.toString()))
            .toBuffer();
        }
        return {Body: response.data,ContentType: response.headers['content-type']};
    }
}
