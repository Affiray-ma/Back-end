/*
  Warnings:

  - You are about to drop the column `image` on the `Machine` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Machine_Part` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `thumb_id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Products_Thumbnails` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User_Thumb` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[image_id]` on the table `Machine` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[image_id]` on the table `Machine_Part` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[image_id]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `image_id` to the `Machine` table without a default value. This is not possible if the table is not empty.
  - Added the required column `image_id` to the `Machine_Part` table without a default value. This is not possible if the table is not empty.
  - Added the required column `image_id` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Maker" DROP CONSTRAINT "Maker_image_id_fkey";

-- DropForeignKey
ALTER TABLE "Products_Thumbnails" DROP CONSTRAINT "Products_Thumbnails_product_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_thumb_id_fkey";

-- DropIndex
DROP INDEX "User_thumb_id_key";

-- AlterTable
ALTER TABLE "Machine" DROP COLUMN "image",
ADD COLUMN     "image_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Machine_Part" DROP COLUMN "image",
ADD COLUMN     "image_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "image";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "thumb_id",
ADD COLUMN     "image_id" TEXT NOT NULL;

-- DropTable
DROP TABLE "Products_Thumbnails";

-- DropTable
DROP TABLE "User_Thumb";

-- CreateTable
CREATE TABLE "Thumbnails" (
    "id" TEXT NOT NULL,
    "dest" TEXT NOT NULL DEFAULT '',
    "product_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Thumbnails_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Thumbnails_product_id_key" ON "Thumbnails"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "Machine_image_id_key" ON "Machine"("image_id");

-- CreateIndex
CREATE UNIQUE INDEX "Machine_Part_image_id_key" ON "Machine_Part"("image_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_image_id_key" ON "User"("image_id");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Thumbnails" ADD CONSTRAINT "Thumbnails_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maker" ADD CONSTRAINT "Maker_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Machine_Part" ADD CONSTRAINT "Machine_Part_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Machine" ADD CONSTRAINT "Machine_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
