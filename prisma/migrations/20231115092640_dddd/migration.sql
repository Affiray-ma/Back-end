-- DropForeignKey
ALTER TABLE "Category" DROP CONSTRAINT "Category_thumbnail_id_fkey";

-- DropForeignKey
ALTER TABLE "Machine" DROP CONSTRAINT "Machine_image_id_fkey";

-- DropForeignKey
ALTER TABLE "Machine_Part" DROP CONSTRAINT "Machine_Part_image_id_fkey";

-- AlterTable
ALTER TABLE "Category" ALTER COLUMN "thumbnail_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Machine" ALTER COLUMN "image_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Machine_Part" ALTER COLUMN "image_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Machine_Part" ADD CONSTRAINT "Machine_Part_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_thumbnail_id_fkey" FOREIGN KEY ("thumbnail_id") REFERENCES "Thumbnails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Machine" ADD CONSTRAINT "Machine_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
