import { Equals, IsDateString, IsEmail, IsNotEmpty, IsOptional, IsPhoneNumber, IsStrongPassword } from "class-validator";


export class CreateUserDto{
    @IsNotEmpty()
    name: string;  
    
    @IsOptional()
    @IsEmail()
    email: string;
    
    @IsStrongPassword()
    password: string;

    @IsOptional()
    @IsPhoneNumber()
    phone: string;
}

export class LoginUserDto{
    @IsEmail()
    @IsOptional()
    email: string;
    @IsPhoneNumber()
    @IsOptional()
    phone: string;
    @IsNotEmpty()
    password: string;
}