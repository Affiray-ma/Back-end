import { HttpException, Injectable } from '@nestjs/common';
import { PrismaClient,Prisma } from '@prisma/client';
import { PrismaService } from 'src/prismaModule/prisma.service';
import { CreateUserDto, LoginUserDto } from './dtos/UserDtos.interface';
import { ValidationError } from 'class-validator';
import * as bcrypt from 'bcrypt';
import { prismaError } from 'prisma-better-errors';
@Injectable()
export class UsersService {
    constructor(private prisma: PrismaService) {}


    async signup(input : CreateUserDto) {
        
        const password = await bcrypt.hash(input.password, 10);
        try{
            const user = await this.prisma.user.create({
                data: input
            })
            return user;
        } catch (e){
            throw new prismaError(e);
        }
    
    }

    async login(input : LoginUserDto) {
        const password = await bcrypt.hash(input.password, 10);
            var where: Prisma.UserWhereUniqueInput = input.email ? {
                email: input.email
            } : {
                phone: input.phone
            }
            //get the user
            const user = await this.prisma.user.findUnique({
                where: where
            })
            //check if the user exists
            if (!user){
                throw new HttpException("User not found", 404);
            }
            //check if the password is correct
            const passwordMatch = await bcrypt.compare(input.password, user.password);
            if (!passwordMatch){
                throw new HttpException("Incorrect password", 401);
            }
            return user;
        
        
    }

    async getUsers(){
        const users = await this.prisma.user.findMany({
            include: {
                image: true,
                
            },
           
            
        })
        return users;
    }

    async deleteUser(id: string){
        const user = await this.prisma.user.deleteMany({
            
        })
        return user;
    }
}
