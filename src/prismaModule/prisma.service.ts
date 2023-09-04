import { INestApplication, Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    console.log("Connecting to database...")
    await this.$connect();
  }

  //override the constructor to prevent multiple connections
  constructor() {
    console.log("Creating new Prisma client...")
    super();
  }
  

}