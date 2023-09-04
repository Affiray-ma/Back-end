/*
  Warnings:

  - You are about to drop the `tracking` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "User" ALTER COLUMN "phone" SET DEFAULT '',
ALTER COLUMN "birth_date" SET DEFAULT '',
ALTER COLUMN "customer_rank" SET DEFAULT 0;

-- DropTable
DROP TABLE "tracking";
