/*
  Warnings:

  - You are about to drop the column `image` on the `Maker` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[image_id]` on the table `Maker` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `image_id` to the `Maker` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Maker" DROP COLUMN "image",
ADD COLUMN     "image_id" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Maker_image_id_key" ON "Maker"("image_id");

-- AddForeignKey
ALTER TABLE "Maker" ADD CONSTRAINT "Maker_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Products_Thumbnails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
