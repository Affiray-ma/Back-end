-- DropForeignKey
ALTER TABLE "Maker" DROP CONSTRAINT "Maker_image_id_fkey";

-- AlterTable
ALTER TABLE "Maker" ALTER COLUMN "image_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Maker" ADD CONSTRAINT "Maker_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Thumbnails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
