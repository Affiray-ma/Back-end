-- CreateTable
CREATE TABLE "tracking" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "is_blacklisted" BOOLEAN NOT NULL DEFAULT false,
    "phone" TEXT NOT NULL,
    "birth_date" TEXT NOT NULL,
    "customer_rank" INTEGER NOT NULL,
    "login_status" BOOLEAN NOT NULL DEFAULT false,
    "role_id" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,
    "team_id" TEXT NOT NULL,
    "userconfig_id" TEXT NOT NULL,
    "location_id" TEXT NOT NULL,
    "thumb_id" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Userconfig" (
    "id" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,
    "currency_id" TEXT NOT NULL,

    CONSTRAINT "Userconfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Currency" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,

    CONSTRAINT "Currency_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Roles" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,

    CONSTRAINT "Roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Warehouse" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "team_id" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,
    "location_id" TEXT NOT NULL,

    CONSTRAINT "Warehouse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,
    "address1" TEXT NOT NULL,
    "address2" TEXT NOT NULL DEFAULT '',
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "latitude" TEXT NOT NULL DEFAULT '0',
    "longitude" TEXT NOT NULL DEFAULT '0',
    "country" TEXT NOT NULL,
    "zip_code" TEXT NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Thumb" (
    "id" TEXT NOT NULL,
    "origin_size" TEXT NOT NULL,
    "extra_large_size" TEXT NOT NULL,
    "large_size" TEXT NOT NULL,
    "medium_size" TEXT NOT NULL,
    "small_size" TEXT NOT NULL,
    "tracking_id" TEXT NOT NULL,

    CONSTRAINT "Thumb_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Search" (
    "id" TEXT NOT NULL,
    "query" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Search_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_tracking_id_key" ON "User"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_userconfig_id_key" ON "User"("userconfig_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_location_id_key" ON "User"("location_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_thumb_id_key" ON "User"("thumb_id");

-- CreateIndex
CREATE UNIQUE INDEX "Userconfig_tracking_id_key" ON "Userconfig"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Userconfig_currency_id_key" ON "Userconfig"("currency_id");

-- CreateIndex
CREATE UNIQUE INDEX "Currency_tracking_id_key" ON "Currency"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Roles_tracking_id_key" ON "Roles"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Team_tracking_id_key" ON "Team"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Warehouse_team_id_key" ON "Warehouse"("team_id");

-- CreateIndex
CREATE UNIQUE INDEX "Warehouse_tracking_id_key" ON "Warehouse"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Warehouse_location_id_key" ON "Warehouse"("location_id");

-- CreateIndex
CREATE UNIQUE INDEX "Location_tracking_id_key" ON "Location"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Thumb_tracking_id_key" ON "Thumb"("tracking_id");

-- CreateIndex
CREATE UNIQUE INDEX "Search_user_id_key" ON "Search"("user_id");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_userconfig_id_fkey" FOREIGN KEY ("userconfig_id") REFERENCES "Userconfig"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_thumb_id_fkey" FOREIGN KEY ("thumb_id") REFERENCES "Thumb"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Userconfig" ADD CONSTRAINT "Userconfig_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Userconfig" ADD CONSTRAINT "Userconfig_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "Currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Currency" ADD CONSTRAINT "Currency_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Roles" ADD CONSTRAINT "Roles_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Location" ADD CONSTRAINT "Location_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Thumb" ADD CONSTRAINT "Thumb_tracking_id_fkey" FOREIGN KEY ("tracking_id") REFERENCES "tracking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
