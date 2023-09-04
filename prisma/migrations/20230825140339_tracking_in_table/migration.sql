/*
  Warnings:

  - You are about to drop the column `tracking_id` on the `Currency` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `Location` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `Roles` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `Team` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `Thumb` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `Userconfig` table. All the data in the column will be lost.
  - You are about to drop the column `tracking_id` on the `Warehouse` table. All the data in the column will be lost.
  - Added the required column `updated_at` to the `Currency` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Location` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Roles` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Team` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Userconfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Warehouse` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Currency" DROP CONSTRAINT "Currency_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "Location" DROP CONSTRAINT "Location_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "Roles" DROP CONSTRAINT "Roles_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "Team" DROP CONSTRAINT "Team_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "Thumb" DROP CONSTRAINT "Thumb_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "Userconfig" DROP CONSTRAINT "Userconfig_tracking_id_fkey";

-- DropForeignKey
ALTER TABLE "Warehouse" DROP CONSTRAINT "Warehouse_tracking_id_fkey";

-- DropIndex
DROP INDEX "Currency_tracking_id_key";

-- DropIndex
DROP INDEX "Location_tracking_id_key";

-- DropIndex
DROP INDEX "Roles_tracking_id_key";

-- DropIndex
DROP INDEX "Team_tracking_id_key";

-- DropIndex
DROP INDEX "Thumb_tracking_id_key";

-- DropIndex
DROP INDEX "User_tracking_id_key";

-- DropIndex
DROP INDEX "Userconfig_tracking_id_key";

-- DropIndex
DROP INDEX "Warehouse_tracking_id_key";

-- AlterTable
ALTER TABLE "Currency" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Location" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Roles" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Team" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Thumb" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Userconfig" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Warehouse" DROP COLUMN "tracking_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;
