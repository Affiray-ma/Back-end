import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';

let PrismaAdapter = null;

import { DMMFClass } from '@prisma/client/runtime/library'


//import { PrismaAdapter } from '@adminjs/prisma';

import { PrismaModule } from './prismaModule/prisma.module';
import { DevToolsModule } from './dev-tools/dev-tools.module';

import { PrismaService } from './prismaModule/prisma.service';
import { PrismaClient} from '@prisma/client';
import *as runtime from '@prisma/client/runtime/library';

const DEFAULT_ADMIN = {
  email: 'admin@example.com',
  password: 'password',
}


//import prismaAdapter from '@adminjs/prisma';


const authenticate = async (email: string, password: string) => {
  if (email === DEFAULT_ADMIN.email && password === DEFAULT_ADMIN.password) {
    return Promise.resolve(DEFAULT_ADMIN)
  }
  return null
}
@Module({
  imports: [UsersModule, AuthModule, PrismaModule, DevToolsModule,
    import('@adminjs/nestjs').then(async ({ AdminModule }) => 
    {
      const prisma = new PrismaClient();
      const PrismaAdapter = await import('@adminjs/prisma');

      const {AdminJS} = await import('adminjs');
      
    
    AdminJS.registerAdapter({
    Resource: PrismaAdapter.Resource,
    Database: PrismaAdapter.Database,
    })
      return AdminModule.createAdminAsync({
      useFactory: () => ({
        adminJsOptions: {
          rootPath: '/admin',
          resources: [{
            resource: { model: PrismaAdapter.getModelByName('User'), client: prisma },
            options: {},

          },
          {
            resource: { model: PrismaAdapter.getModelByName('Userconfig'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Currency'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Roles'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Team'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Warehouse'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Location'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Search'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Thumbnails'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Product'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Maker'), client: prisma },
            options: {},
            
          },{
            resource: { model: PrismaAdapter.getModelByName('Roles'), client: prisma },
            options: {},
            
          }
        ],
        },
        auth: {
          authenticate,
          cookieName: 'adminjs',
          cookiePassword: 'secret'
        },
        
        sessionOptions: {
          resave: true,
          saveUninitialized: true,
          secret: 'secret'
        },
      }),
    })}),
    
  ],
  controllers: [AppController],
  providers: [AppService],

  
})
export class AppModule {}
