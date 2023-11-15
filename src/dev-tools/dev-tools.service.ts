import { Injectable } from '@nestjs/common';
import { S3Service } from './s3.service';
import { PrismaClient } from '@prisma/client';
import { HttpService } from '@nestjs/axios';

import * as axios from 'axios';
import { Observable, firstValueFrom } from 'rxjs';

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
}
