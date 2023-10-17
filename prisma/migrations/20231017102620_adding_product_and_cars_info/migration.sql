/*
  Warnings:

  - You are about to drop the `Thumb` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_thumb_id_fkey";

-- DropTable
DROP TABLE "Thumb";

-- CreateTable
CREATE TABLE "User_Thumb" (
    "id" TEXT NOT NULL,
    "dest" TEXT NOT NULL DEFAULT '',
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_Thumb_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products_Thumbnails" (
    "id" TEXT NOT NULL,
    "dest" TEXT NOT NULL DEFAULT '',
    "product_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Products_Thumbnails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "image" TEXT NOT NULL DEFAULT '',
    "price" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "reference_id" TEXT NOT NULL,
    "warehouse_id" TEXT NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Maker" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "image" TEXT NOT NULL DEFAULT '',
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Maker_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Car_Model" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "maker_id" TEXT NOT NULL,

    CONSTRAINT "Car_Model_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reference" (
    "id" TEXT NOT NULL,
    "reference" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "machine_part_id" TEXT NOT NULL,
    "maker_id" TEXT NOT NULL,

    CONSTRAINT "Reference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Machine_Part" (
    "id" TEXT NOT NULL,
    "reference" TEXT NOT NULL,
    "image" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "machine_id" TEXT NOT NULL,

    CONSTRAINT "Machine_Part_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Machine" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "image" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Machine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_Car_ModelToReference" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_Thumb_user_id_key" ON "User_Thumb"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Products_Thumbnails_product_id_key" ON "Products_Thumbnails"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "_Car_ModelToReference_AB_unique" ON "_Car_ModelToReference"("A", "B");

-- CreateIndex
CREATE INDEX "_Car_ModelToReference_B_index" ON "_Car_ModelToReference"("B");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_thumb_id_fkey" FOREIGN KEY ("thumb_id") REFERENCES "User_Thumb"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_Thumbnails" ADD CONSTRAINT "Products_Thumbnails_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_reference_id_fkey" FOREIGN KEY ("reference_id") REFERENCES "Reference"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Car_Model" ADD CONSTRAINT "Car_Model_maker_id_fkey" FOREIGN KEY ("maker_id") REFERENCES "Maker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reference" ADD CONSTRAINT "Reference_machine_part_id_fkey" FOREIGN KEY ("machine_part_id") REFERENCES "Machine_Part"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reference" ADD CONSTRAINT "Reference_maker_id_fkey" FOREIGN KEY ("maker_id") REFERENCES "Maker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Machine_Part" ADD CONSTRAINT "Machine_Part_machine_id_fkey" FOREIGN KEY ("machine_id") REFERENCES "Machine"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Car_ModelToReference" ADD CONSTRAINT "_Car_ModelToReference_A_fkey" FOREIGN KEY ("A") REFERENCES "Car_Model"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Car_ModelToReference" ADD CONSTRAINT "_Car_ModelToReference_B_fkey" FOREIGN KEY ("B") REFERENCES "Reference"("id") ON DELETE CASCADE ON UPDATE CASCADE;
