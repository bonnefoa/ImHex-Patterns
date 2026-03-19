#pragma author "Anthonin Bonnefoy"
#pragma description "PostgreSQL Heap Page Format"
#pragma little endian

import std.core;
import std.mem;
import std.string;

using TransactionId = u32;
using XLogRecPtr = u64 [[format("format_xlogrecptr")]];
using OffsetNumber = u16;

fn format_xlogrecptr(auto rec_ptr) {
    return std::format("{:X}/{:X}", rec_ptr >> 32, rec_ptr & 0xffffffff);
};

struct PageHeaderData {
  XLogRecPtr pd_lsn;
  u16 pd_checksum;
  u16 pd_flags;
  u16 pd_lower;
  u16 pd_upper;
  u16 pd_special;
  u16 pd_pagesize_version;
  TransactionId pd_prune_xid;
};

struct BlockIdData {
  u16 bi_hi;
  u16 bi_lo;
};

struct ItemPointerData {
  BlockIdData ip_blkid;
  OffsetNumber ip_posid;
};

struct HeapTupleHeaderData {
  TransactionId t_xmin;
  TransactionId t_xmax;
  u32 t_cid;
  ItemPointerData t_ctid;
  u16 t_infomask2;
  u16 t_infomask;
  u8 t_hoff;
  // Todo: bitmaps may not be present
  u8 t_bits;
};

u8 current_lp;

struct HeapTupleData {
  $ = parent.start_address + parent.line_pointers[current_lp].lp_off;
  auto start_address = $;
  HeapTupleHeaderData header;
  u8 data[parent.line_pointers[current_lp].lp_len - ($ - start_address)];
  current_lp = current_lp + 1;
};

bitfield ItemIdData {
  lp_off   : 15;
  lp_flags : 2;
  lp_len   : 15;
};

struct Page {
  auto start_address = $;
  PageHeaderData header;
  // Read line pointers until we reach the start of free space
  ItemIdData line_pointers[while (($ - start_address) < header.pd_lower)];
  current_lp = 0;
  HeapTupleData heap_data[std::core::member_count(line_pointers)];
} [[fixed_size(8192)]];

Page pages[while (!std::mem::eof())] @$;
