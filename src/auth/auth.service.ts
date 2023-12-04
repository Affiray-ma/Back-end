import { HttpException, Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
    constructor(
        private readonly prisma: PrismaClient,
    ) {}
    async getUserByLogin(login :string){
        const emailRegex = /\S+@\S+\.\S+/;
        if (emailRegex.test(login)) {
            return   await this.prisma.user.findUnique({
                where: {
                    email: login
                }  
            })
          } else {
            return  await this.prisma.user.findUnique({
                where: {
                    phone : login
                }  
            })
          }
        
    }
    async authenticateUser(login: string, password: string) {
        //check if the login is mobile or email
        const user = await this.getUserByLogin(login);
        if(!user){
            //throw user not found with credentials
            throw new HttpException("Not authorized", 401);
            
        }
        const pass= await bcrypt.hash(password, 10);
        //check if the password is correct
        const passwordMatch = await bcrypt.compare(password, user.password);
        if (!passwordMatch){
            //throw incorrect password
            throw new HttpException("Not authorized", 401);
        }
        return user;
    }
}
