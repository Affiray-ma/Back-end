-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_location_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_team_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_thumb_id_fkey";

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "team_id" DROP NOT NULL,
ALTER COLUMN "userconfig_id" DROP NOT NULL,
ALTER COLUMN "location_id" DROP NOT NULL,
ALTER COLUMN "thumb_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "Location"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_thumb_id_fkey" FOREIGN KEY ("thumb_id") REFERENCES "Thumb"("id") ON DELETE SET NULL ON UPDATE CASCADE;
