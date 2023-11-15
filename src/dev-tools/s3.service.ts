import { Injectable } from '@nestjs/common';
import {S3} from 'aws-sdk';
import { Buffer } from 'buffer';
import sharp from 'sharp';
import * as fs from 'fs';
@Injectable()
export class S3Service {
    AWS_S3_BUCKET = "afiraybuckets";
    s3 = new S3({
        accessKeyId: 'AKIAWN35EU7KCQJDXK52',
        secretAccessKey: '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',
    });
    async uploadBinFile(buffer,key:string,contentType:string) {
        const params = {
            Bucket: this.AWS_S3_BUCKET,
            Key:  key,
            Body: buffer,
            ContentType: contentType,
        }; 
        const  Location  = await this.s3.putObject(params).promise();
        console.log(Location);
        return Location;
    }

    async uploadFile(file,key:string) {     
        const params = {
            Bucket: this.AWS_S3_BUCKET,
            Key:  key,
            Body: file,
            ContentEncoding: 'base64',
            ContentType: 'image/png',
        }; 
        const  Location  = await this.s3.upload(params).promise();
        console.log(Location);
        return Location;
    }
    async getFile(key:string,size:number) {
        const paramsa : S3.GetObjectRequest = {
            Bucket: this.AWS_S3_BUCKET,
            Key:  key,
        };
        //transform the image to binary and send it with content type 

        const  Location  = await this.s3.getObject(paramsa).promise();
        // the uni8array is the image i want to open it get the content type and send it with the content type
        //const buffer = Buffer.from(Location.Body.toString());

        var resizedImage = Location.Body;
        if (size){
            resizedImage = await sharp(Location.Body as Buffer)
      .resize(parseInt(size.toString()))
      .toBuffer();
        }
        // get the meme type
        
        //const data = await sharp(buffer).metadata();
        console.log(Location);
        return {Body : resizedImage,ContentType: Location.ContentType};

    }
}