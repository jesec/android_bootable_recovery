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

#ifndef __ZIPWRAP_HPP
#define __ZIPWRAP_HPP

#include <string>
#include <ziparchive/zip_archive.h>
#include "otautil/sysutil.h"

using namespace std;

class ZipWrap {
	public:
		ZipWrap();
		~ZipWrap();

		bool Open(const char* file, MemMapping* map);
		void Close();
		bool EntryExists(const string& filename);
		bool ExtractEntry(const string& source_file, const string& target_file, mode_t mode);

		long GetUncompressedSize(const string& filename);
		bool ExtractToBuffer(const string& filename, uint8_t* begin);
		bool ExtractRecursive(const string& source_dir, const string& target_dir);
		off64_t GetEntryOffset(const string& filename);
		ZipArchiveHandle GetZipArchiveHandle();

	private:
		ZipArchiveHandle Zip;
		string zip_file;
		bool zip_open;
};

#endif //__ZIPWRAP_HPP
