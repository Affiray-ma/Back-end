import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { UsersService } from 'src/users/users.service';
import { UsersModule } from 'src/users/users.module';
import { PrismaService } from 'src/prismaModule/prisma.service';
import { PrismaModule } from 'src/prismaModule/prisma.module';

@Module({
  controllers: [AuthController],
  providers: [AuthService,UsersService],
  imports: [UsersModule,PrismaModule],
})

export class AuthModule {}
