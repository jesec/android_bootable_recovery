/*
 * Copyright (C) TeamWin
 * This file is part of TWRP/TeamWin Recovery Project.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "zipwrap.hpp"
#include <string>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <ziparchive/zip_archive.h>
#include "ZipUtil.h"
#include "otautil/sysutil.h"

ZipWrap::ZipWrap() {
	zip_open = false;
}

ZipWrap::~ZipWrap() {
	if (zip_open)
		Close();
}

bool ZipWrap::Open(const char* file, MemMapping* map) {
	if (zip_open) {
		printf("ZipWrap '%s' is already open\n", zip_file.c_str());
		return true;
	}
	zip_file = file;
	if (OpenArchiveFromMemory(map->addr, map->length, file, &Zip) != 0)
		return false;
	zip_open = true;
	return true;
}

void ZipWrap::Close() {
	if (zip_open)
		CloseArchive(Zip);
	zip_open = false;
}

bool ZipWrap::EntryExists(const string& filename) {
	ZipString zip_string(filename.c_str());
	ZipEntry file_entry;

	if (FindEntry(Zip, zip_string, &file_entry) != 0)
		return false;
	return true;
}

bool ZipWrap::ExtractEntry(const string& source_file, const string& target_file, mode_t mode) {
	if (access(target_file.c_str(), F_OK) == 0 && unlink(target_file.c_str()) != 0)
		printf("Unable to unlink '%s': %s\n", target_file.c_str(), strerror(errno));
	
	int fd = creat(target_file.c_str(), mode);
	if (fd < 0) {
		printf("Failed to create '%s'\n", target_file.c_str());
		return false;
	}

	ZipString zip_string(source_file.c_str());
	ZipEntry file_entry;

	if (FindEntry(Zip, zip_string, &file_entry) != 0)
		return false;
	int32_t ret_val = ExtractEntryToFile(Zip, &file_entry, fd);
	close(fd);

	if (ret_val != 0) {
		printf("Could not extract '%s'\n", target_file.c_str());
		return false;
	}
	return true;
}

bool ZipWrap::ExtractRecursive(const string& source_dir, const string& target_dir) {
	struct utimbuf timestamp = { 1217592000, 1217592000 };  // 8/1/2008 default
	return ExtractPackageRecursive(Zip, source_dir, target_dir, &timestamp, NULL);
}

long ZipWrap::GetUncompressedSize(const string& filename) {
	ZipString zip_string(filename.c_str());
	ZipEntry file_entry;

	if (FindEntry(Zip, zip_string, &file_entry) != 0)
		return 0;
	return file_entry.uncompressed_length;
}

bool ZipWrap::ExtractToBuffer(const string& filename, uint8_t* buffer) {
	ZipString zip_string(filename.c_str());
	ZipEntry file_entry;

	if (FindEntry(Zip, zip_string, &file_entry) != 0)
		return false;
	if (ExtractToMemory(Zip, &file_entry, buffer, file_entry.uncompressed_length) != 0) {
		printf("Failed to read '%s'\n", filename.c_str());
		return false;
	}
	return true;
}

off64_t ZipWrap::GetEntryOffset(const string& filename) {
	ZipString zip_string(filename.c_str());
	ZipEntry file_entry;

	if (FindEntry(Zip, zip_string, &file_entry) != 0) {
		printf("'%s' does not exist in zip '%s'\n", filename.c_str(), zip_file.c_str());
		return 0;
	}
	return file_entry.offset;
}

ZipArchiveHandle ZipWrap::GetZipArchiveHandle() {
	return Zip;
}
