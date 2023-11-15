/*
  Warnings:

  - You are about to drop the column `reference` on the `Machine_Part` table. All the data in the column will be lost.
  - Added the required column `name` to the `Machine_Part` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Machine_Part" DROP COLUMN "reference",
ADD COLUMN     "name" TEXT NOT NULL;
