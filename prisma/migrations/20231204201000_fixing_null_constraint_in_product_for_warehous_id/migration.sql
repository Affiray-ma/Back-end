-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_warehouse_id_fkey";

-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "warehouse_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "Warehouse"("id") ON DELETE SET NULL ON UPDATE CASCADE;
