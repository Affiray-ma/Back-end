/*
  Warnings:

  - Added the required column `bg_color` to the `Machine_Part` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Machine_Part" ADD COLUMN     "bg_color" TEXT NOT NULL;
