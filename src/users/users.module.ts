import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { PrismaService } from 'src/prismaModule/prisma.service';
import { AppModule } from 'src/app.module';
import { PrismaModule } from 'src/prismaModule/prisma.module';
;

@Module({
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService],
  imports: [PrismaModule],
  
})
export class UsersModule {}
