import { Body, Controller, Delete, Get, Post, Put, Req } from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto, LoginUserDto } from './dtos/UserDtos.interface';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post("signup")
  async signup(@Body() request : CreateUserDto) {
      const user = await this.usersService.signup(request);
      return user; 
  }  
  @Post("login")
  async login(@Body() request : LoginUserDto) {
      const user = await this.usersService.login(request);
      return user; 
  }
  @Get("users")
  async getUsers() {
      const users = await this.usersService.getUsers();
      return users; 
  }
  @Delete("users")
  async deleteUser(@Req() request) {
      const users = await this.usersService.deleteUser(request.params.id);
      return users; 
  }
 

  

  
}
