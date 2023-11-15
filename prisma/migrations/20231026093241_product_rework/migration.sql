/*
  Warnings:

  - You are about to drop the column `reference_id` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the `Reference` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_Car_ModelToReference` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `machine_id` to the `Car_Model` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Car_Model` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `references` to the `Product` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_reference_id_fkey";

-- DropForeignKey
ALTER TABLE "Reference" DROP CONSTRAINT "Reference_machine_part_id_fkey";

-- DropForeignKey
ALTER TABLE "Reference" DROP CONSTRAINT "Reference_maker_id_fkey";

-- DropForeignKey
ALTER TABLE "_Car_ModelToReference" DROP CONSTRAINT "_Car_ModelToReference_A_fkey";

-- DropForeignKey
ALTER TABLE "_Car_ModelToReference" DROP CONSTRAINT "_Car_ModelToReference_B_fkey";

-- AlterTable
ALTER TABLE "Car_Model" ADD COLUMN     "machine_id" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "reference_id",
ADD COLUMN     "category_id" TEXT NOT NULL,
ADD COLUMN     "references" TEXT NOT NULL;

-- DropTable
DROP TABLE "Reference";

-- DropTable
DROP TABLE "_Car_ModelToReference";

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "machine_part_id" TEXT NOT NULL,
    "thumbnail_id" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_Car_ModelToProduct" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Category_thumbnail_id_key" ON "Category"("thumbnail_id");

-- CreateIndex
CREATE UNIQUE INDEX "_Car_ModelToProduct_AB_unique" ON "_Car_ModelToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_Car_ModelToProduct_B_index" ON "_Car_ModelToProduct"("B");

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Car_Model" ADD CONSTRAINT "Car_Model_machine_id_fkey" FOREIGN KEY ("machine_id") REFERENCES "Machine"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_machine_part_id_fkey" FOREIGN KEY ("machine_part_id") REFERENCES "Machine_Part"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_thumbnail_id_fkey" FOREIGN KEY ("thumbnail_id") REFERENCES "Thumbnails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Car_ModelToProduct" ADD CONSTRAINT "_Car_ModelToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Car_Model"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Car_ModelToProduct" ADD CONSTRAINT "_Car_ModelToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
