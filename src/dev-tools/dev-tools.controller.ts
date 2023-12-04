import { Body, Controller, Get, Param, Post, Query, Res } from '@nestjs/common';
import { DevToolsService } from './dev-tools.service';
import { S3Service } from './s3.service';
import { async } from 'rxjs';
import { get } from 'axios';

@Controller('dev-tools')
export class DevToolsController {
  constructor(private readonly devToolsService: DevToolsService,private readonly s3Service: S3Service) {

  }

  @Post('s3')
  async s3(@Body() body: any) {
    //the body has a base64 image in a param called image
    const buffer = Buffer.from(body.image.replace(/^data:image\/\w+;base64,/, ''), 'base64');
    const result = await this.s3Service.uploadFile(buffer, 'test.jpg');
    return result;
  }
  @Get('s33')
  async s3get(@Res() res: any) {
  //send the image as a image 
  //  const image= await this.s3Service.getFile('test.jpg');
  //  //transform the image to binary and send it with content type image/png
  //   res.writeHead(200, {
  //     'Content-Type': 'image/png',
  //   });
  //   res.end(image.Body);
  //   return image;
  }
  @Post("Postmaker/")
  async PostData(@Body() body) {
    const result = await this.devToolsService.PostMaker(body);
    return result;
  }

  @Get("makers")
  async getMakers() {
    const result = await this.devToolsService.getMakers();
    return result;
  }
  @Get("delete")
  async deleteMakers() {
    const result = await this.devToolsService.deleteMakers();
    return result;
  }
  @Get("image")
  async getImage(@Body() body: any,@Query('key') key:string,@Query("s")size : number,@Res() res: any) {
    //check if the key has http or https
    const is_local = key.includes("http");
    if(!is_local){
    const result = await this.s3Service.getFile(key,size);
    //transform the image to binary and send it with content type image/png
    // res.writeHead(200, {
    //   'Content-Type': 'octet-stream',
    // });
    res.writeHead(200, {
      'Content-Type': result.ContentType,
    });
    //set the contenst type to the image type
    res.end(result.Body);
  }else{
    const result = await this.devToolsService.get_external_image(key,size);
    res.writeHead(200, {
      'Content-Type': result.ContentType,
   
    })
    res.end(result.Body);
  }
    //return result;
  }
  @Post("maker")
  async PostMaker(@Body() body) {
    const result = await this.devToolsService.PostMaker2(body);
    return result;
  }
  @Post("machine")
  async PostMachine(@Body() body) {
    const result = await this.devToolsService.CreateMachine();
    return result;
  }
  @Post("model")
  async PostModel(@Body() body) {
    const result = await this.devToolsService.PostModel(body);
    return result;
  }
  @Post("category")
  async PostCategory(@Body() body) {
    const result = await this.devToolsService.PostCaTegory(body);
    return result;
  }
  @Post("part")
  async PostPart(@Body() body) {
    const result = await this.devToolsService.PostMachinePart(body);
    return result;
  }
  @Get('deleteall')
  async deleteAll() {
    const result = await this.devToolsService.deleteAll();
    return result;
  }

  @Get("mok_users")
  async mok_users() {
    const result = await this.devToolsService.mok_users();
    return result;
  }

  @Post("mok_products")
  async mok_products() {
    const result = await this.devToolsService.mok_products();
    return result;
  }
  @Get("products")
  async getProducts() {
    const result = await this.devToolsService.getProducts();
    return result;
  }
}
