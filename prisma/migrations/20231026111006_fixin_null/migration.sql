-- DropForeignKey
ALTER TABLE "Thumbnails" DROP CONSTRAINT "Thumbnails_product_id_fkey";

-- AlterTable
ALTER TABLE "Thumbnails" ALTER COLUMN "product_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Thumbnails" ADD CONSTRAINT "Thumbnails_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;
