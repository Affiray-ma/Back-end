import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { UsersService } from 'src/users/users.service';
import { UsersModule } from 'src/users/users.module';
import { PrismaService } from 'src/prismaModule/prisma.service';
import { PrismaModule } from 'src/prismaModule/prisma.module';
import { LocalStrategy } from './strategies/local.strategy';
import { PrismaClient } from '@prisma/client';
import { JwtModule } from '@nestjs/jwt';
@Module({
  controllers: [AuthController],
  providers: [AuthService,LocalStrategy,PrismaClient],
  imports: [UsersModule,PrismaModule,JwtModule.register({
    global: true,
    secret:'tiza',
    signOptions: { expiresIn: '10m' },
  })],
  exports: [],
})

export class AuthModule {}
