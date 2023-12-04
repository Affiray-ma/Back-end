-- DropIndex
DROP INDEX "Userconfig_currency_id_key";

-- AlterTable
ALTER TABLE "Userconfig" ALTER COLUMN "currency_id" SET DEFAULT '';
