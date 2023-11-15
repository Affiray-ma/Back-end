import { Module } from '@nestjs/common';
import { DevToolsService } from './dev-tools.service';
import { DevToolsController } from './dev-tools.controller';
import { S3Service } from './s3.service';
import { PrismaModule } from 'src/prismaModule/prisma.module';
import { PrismaClient } from '@prisma/client';
import { HttpModule } from '@nestjs/axios';
// import 

@Module({
  controllers: [DevToolsController],
  imports: [PrismaModule,HttpModule],
  providers: [DevToolsService, S3Service,PrismaClient]
})
export class DevToolsModule {}
