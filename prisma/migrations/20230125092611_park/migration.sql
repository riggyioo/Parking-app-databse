/*
  Warnings:

  - Added the required column `contact` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `img` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `user` ADD COLUMN `contact` INTEGER NOT NULL,
    ADD COLUMN `img` VARCHAR(191) NOT NULL,
    ADD COLUMN `role` VARCHAR(191) NOT NULL;

-- CreateTable
CREATE TABLE `admin` (
    `email` VARCHAR(191) NOT NULL,
    `district` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL AUTO_INCREMENT,

    UNIQUE INDEX `admin_email_key`(`email`),
    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `parkat` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `zoneId` INTEGER NOT NULL,

    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offence` (
    `offId` INTEGER NOT NULL AUTO_INCREMENT,
    `offType` VARCHAR(191) NOT NULL,
    `fineAmt` INTEGER NOT NULL,

    PRIMARY KEY (`offId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `zone` (
    `zoneId` INTEGER NOT NULL AUTO_INCREMENT,
    `zoneName` VARCHAR(191) NOT NULL,
    `zoneImg` VARCHAR(191) NOT NULL,
    `disId` INTEGER NOT NULL,

    PRIMARY KEY (`zoneId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `zonefee` (
    `feeId` INTEGER NOT NULL,
    `zoId` INTEGER NOT NULL,

    PRIMARY KEY (`feeId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fee` (
    `feeId` INTEGER NOT NULL AUTO_INCREMENT,
    `typeId` INTEGER NOT NULL,
    `feeAmt` INTEGER NOT NULL,

    PRIMARY KEY (`feeId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `district` (
    `districtId` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `dzongkhag` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`districtId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report` (
    `reportId` INTEGER NOT NULL AUTO_INCREMENT,
    `reportTime` DATETIME(3) NOT NULL,
    `fineStatus` BOOLEAN NOT NULL,
    `zoneName` INTEGER NOT NULL,
    `offenceId` INTEGER NOT NULL,
    `parkAttendId` INTEGER NOT NULL,
    `vehicleNo` INTEGER NOT NULL,

    PRIMARY KEY (`reportId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reportImg` (
    `reportId` INTEGER NOT NULL,
    `imageLink` INTEGER NOT NULL,

    PRIMARY KEY (`reportId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment` (
    `paymentId` INTEGER NOT NULL AUTO_INCREMENT,
    `journalNo` INTEGER NOT NULL,
    `accountNo` INTEGER NOT NULL,
    `bank` VARCHAR(191) NOT NULL,
    `amount` INTEGER NOT NULL,
    `vehicleNo` INTEGER NOT NULL,
    `zoneId` INTEGER NOT NULL,
    `registerId` INTEGER NOT NULL,

    UNIQUE INDEX `payment_journalNo_key`(`journalNo`),
    UNIQUE INDEX `payment_accountNo_key`(`accountNo`),
    PRIMARY KEY (`paymentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vehicle` (
    `vehicleNo` INTEGER NOT NULL AUTO_INCREMENT,
    `typeId` INTEGER NOT NULL,

    PRIMARY KEY (`vehicleNo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vehicleType` (
    `tyId` INTEGER NOT NULL AUTO_INCREMENT,
    `vehicleT` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`tyId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `register` (
    `registerId` INTEGER NOT NULL AUTO_INCREMENT,
    `startTime` DATETIME(3) NOT NULL,
    `endTime` DATETIME(3) NOT NULL,

    PRIMARY KEY (`registerId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `admin` ADD CONSTRAINT `admin_district_fkey` FOREIGN KEY (`district`) REFERENCES `district`(`districtId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `admin` ADD CONSTRAINT `admin_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `parkat` ADD CONSTRAINT `parkat_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `zone` ADD CONSTRAINT `zone_disId_fkey` FOREIGN KEY (`disId`) REFERENCES `district`(`districtId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `zonefee` ADD CONSTRAINT `zonefee_feeId_fkey` FOREIGN KEY (`feeId`) REFERENCES `fee`(`feeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `zonefee` ADD CONSTRAINT `zonefee_zoId_fkey` FOREIGN KEY (`zoId`) REFERENCES `zone`(`zoneId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `fee` ADD CONSTRAINT `fee_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `vehicleType`(`tyId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `report_offenceId_fkey` FOREIGN KEY (`offenceId`) REFERENCES `offence`(`offId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `report_parkAttendId_fkey` FOREIGN KEY (`parkAttendId`) REFERENCES `parkat`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `report_vehicleNo_fkey` FOREIGN KEY (`vehicleNo`) REFERENCES `vehicle`(`vehicleNo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reportImg` ADD CONSTRAINT `reportImg_reportId_fkey` FOREIGN KEY (`reportId`) REFERENCES `report`(`reportId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment` ADD CONSTRAINT `payment_vehicleNo_fkey` FOREIGN KEY (`vehicleNo`) REFERENCES `vehicle`(`vehicleNo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment` ADD CONSTRAINT `payment_zoneId_fkey` FOREIGN KEY (`zoneId`) REFERENCES `zone`(`zoneId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment` ADD CONSTRAINT `payment_registerId_fkey` FOREIGN KEY (`registerId`) REFERENCES `register`(`registerId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vehicle` ADD CONSTRAINT `vehicle_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `vehicleType`(`tyId`) ON DELETE RESTRICT ON UPDATE CASCADE;
