#pragma author "Anthonin Bonnefoy"
#pragma description "PostgreSQL WAL (Write-Ahead Log) Format"
#pragma little endian
#pragma magic [D1 18] @ 0x00

#define XLR_MAX_BLOCK_ID 32
#define XLR_BLOCK_ID_DATA_SHORT   255
#define XLR_BLOCK_ID_DATA_LONG    254
#define XLR_INFO_MASK    0x0f

#define XLOG_CHECKPOINT_SHUTDOWN        0x00
#define XLOG_CHECKPOINT_ONLINE          0x10
#define XLOG_NOOP                       0x20
#define XLOG_NEXTOID                    0x30
#define XLOG_SWITCH                     0x40
#define XLOG_BACKUP_END                 0x50
#define XLOG_PARAMETER_CHANGE           0x60
#define XLOG_RESTORE_POINT              0x70
#define XLOG_FPW_CHANGE                 0x80
#define XLOG_END_OF_RECOVERY            0x90
#define XLOG_FPI_FOR_HINT               0xA0
#define XLOG_FPI                        0xB0
#define XLOG_OVERWRITE_CONTRECORD       0xD0
#define XLOG_CHECKPOINT_REDO            0xE0
#define XLOG_LOGICAL_DECODING_STATUS_CHANGE 0xF0

#define XLOG_XACT_COMMIT            0x00
#define XLOG_XACT_PREPARE           0x10
#define XLOG_XACT_ABORT             0x20
#define XLOG_XACT_COMMIT_PREPARED   0x30
#define XLOG_XACT_ABORT_PREPARED    0x40
#define XLOG_XACT_ASSIGNMENT        0x50
#define XLOG_XACT_INVALIDATIONS     0x60

#define XLOG_HEAP_INSERT     0x00
#define XLOG_HEAP_DELETE     0x10
#define XLOG_HEAP_UPDATE     0x20
#define XLOG_HEAP_TRUNCATE   0x30
#define XLOG_HEAP_HOT_UPDATE 0x40
#define XLOG_HEAP_CONFIRM    0x50
#define XLOG_HEAP_LOCK       0x60
#define XLOG_HEAP_INPLACE    0x70

#define XLOG_HEAP2_REWRITE              0x00
#define XLOG_HEAP2_PRUNE_ON_ACCESS      0x10
#define XLOG_HEAP2_PRUNE_VACUUM_SCAN    0x20
#define XLOG_HEAP2_PRUNE_VACUUM_CLEANUP 0x30
#define XLOG_HEAP2_VISIBLE              0x40
#define XLOG_HEAP2_MULTI_INSERT         0x50
#define XLOG_HEAP2_LOCK_UPDATED         0x60
#define XLOG_HEAP2_NEW_CID              0x70

#define XLOG_HEAP_INIT_PAGE             0x80

#define XLH_INSERT_ALL_VISIBLE_CLEARED  (1<<0)
#define XLH_INSERT_LAST_IN_MULTI        (1<<1)
#define XLH_INSERT_IS_SPECULATIVE       (1<<2)
#define XLH_INSERT_CONTAINS_NEW_TUPLE   (1<<3)
#define XLH_INSERT_ON_TOAST_RELATION    (1<<4)
#define XLH_INSERT_ALL_FROZEN_SET       (1<<5)

#define XLH_UPDATE_OLD_ALL_VISIBLE_CLEARED  (1<<0)
#define XLH_UPDATE_NEW_ALL_VISIBLE_CLEARED  (1<<1)
#define XLH_UPDATE_CONTAINS_OLD_TUPLE       (1<<2)
#define XLH_UPDATE_CONTAINS_OLD_KEY         (1<<3)
#define XLH_UPDATE_CONTAINS_NEW_TUPLE       (1<<4)
#define XLH_UPDATE_PREFIX_FROM_OLD          (1<<5)
#define XLH_UPDATE_SUFFIX_FROM_OLD          (1<<6)

#define XLH_DELETE_ALL_VISIBLE_CLEARED      (1<<0)
#define XLH_DELETE_CONTAINS_OLD_TUPLE       (1<<1)
#define XLH_DELETE_CONTAINS_OLD_KEY         (1<<2)
#define XLH_DELETE_IS_SUPER                 (1<<3)
#define XLH_DELETE_IS_PARTITION_MOVE        (1<<4)

#define XLH_TRUNCATE_CASCADE                (1<<0)
#define XLH_TRUNCATE_RESTART_SEQS           (1<<1)

#define XLH_LOCK_ALL_FROZEN_CLEARED         (1<<0)

#define XLHL_XMAX_IS_MULTI                  0x01
#define XLHL_XMAX_LOCK_ONLY                 0x02
#define XLHL_XMAX_EXCL_LOCK                 0x04
#define XLHL_XMAX_KEYSHR_LOCK               0x08
#define XLHL_KEYS_UPDATED                   0x10

#define XLH_FREEZE_XVAC                     0x02
#define XLH_INVALID_XVAC                    0x04

#define   XLHP_IS_CATALOG_REL         (1 << 1)
#define   XLHP_CLEANUP_LOCK           (1 << 2)
#define   XLHP_HAS_CONFLICT_HORIZON   (1 << 3)

#define XLOG_HEAP_OPMASK            0x70
#define XLOG_HEAP2_OPMASK           0x70
#define XLOG_XACT_OPMASK            0x70

#define XLOG_XACT_HAS_INFO          0x80

#define XACT_XINFO_HAS_DBINFO           (1 << 0)
#define XACT_XINFO_HAS_SUBXACTS         (1 << 1)
#define XACT_XINFO_HAS_RELFILELOCATORS  (1 << 2)
#define XACT_XINFO_HAS_INVALS           (1 << 3)
#define XACT_XINFO_HAS_TWOPHASE         (1 << 4)
#define XACT_XINFO_HAS_ORIGIN           (1 << 5)
#define XACT_XINFO_HAS_AE_LOCKS         (1 << 6)
#define XACT_XINFO_HAS_GID              (1 << 7)
#define XACT_XINFO_HAS_DROPPED_STATS    (1 << 8)

#define XLOG_STANDBY_LOCK       0x00
#define XLOG_RUNNING_XACTS      0x10
#define XLOG_INVALIDATIONS      0x20

#define XLOG_BTREE_INSERT_LEAF	0x00	/* add index tuple without split */
#define XLOG_BTREE_INSERT_UPPER 0x10	/* same, on a non-leaf page */
#define XLOG_BTREE_INSERT_META	0x20	/* same, plus update metapage */
#define XLOG_BTREE_SPLIT_L		0x30	/* add index tuple with split */
#define XLOG_BTREE_SPLIT_R		0x40	/* as above, new item on right */
#define XLOG_BTREE_INSERT_POST	0x50	/* add index tuple with posting split */
#define XLOG_BTREE_DEDUP		0x60	/* deduplicate tuples for a page */
#define XLOG_BTREE_DELETE		0x70	/* delete leaf index tuples for a page */
#define XLOG_BTREE_UNLINK_PAGE	0x80	/* delete a half-dead page */
#define XLOG_BTREE_UNLINK_PAGE_META 0x90	/* same, and update metapage */
#define XLOG_BTREE_NEWROOT		0xA0	/* new root page */
#define XLOG_BTREE_MARK_PAGE_HALFDEAD 0xB0	/* mark a leaf as half-dead */
#define XLOG_BTREE_VACUUM		0xC0	/* delete entries on a page during vacuum */
#define XLOG_BTREE_REUSE_PAGE	0xD0	/* old page is about to be reused from FSM */
#define XLOG_BTREE_META_CLEANUP	0xE0	/* update cleanup-related data in the metapage */

#define SHAREDINVALCATALOG_ID   (-1)
#define SHAREDINVALRELCACHE_ID  (-2)
#define SHAREDINVALSMGR_ID      (-3)
#define SHAREDINVALRELMAP_ID    (-4)
#define SHAREDINVALSNAPSHOT_ID  (-5)
#define SHAREDINVALRELSYNC_ID   (-6)

import std.string;
import type.size;
import std.core;
import type.magic;
import std.mem;
import type.time;

using TransactionId = u32;
using MultiXactId = TransactionId;
using Oid = u32;
using BlockNumber = u32;
using TimeLineID = u32;
using XLogRecPtr = u64 [[format("format_xlogrecptr")]];
using TimestampTz = u64;
using OffsetNumber = u16;
using pg_time_t = type::time64_t;
using ItemPointerData = u64;
using CommandId = u32;
using FullTransactionId = u64;
using MultiXactOffset = u32;
using RmgrId;

// Global variables
u32 globalPageSize = 8192;
u32 main_data_length;
u8 rmgr_info;
RmgrId rmgr_id;
u8 current_block;


struct RelFileLocator {
    u32 spcOid;
    u32 dbOid;
    u32 relNumber;
} [[format("format_rel_file_locator")]];

fn format_rel_file_locator(auto rlocator) {
    str result;
    return std::format("{}/{}/{}", rlocator.spcOid, rlocator.dbOid, rlocator.relNumber);
};

fn format_xlogrecptr(auto rec_ptr) {
    str result;
    return std::format("{:X}/{:X}", rec_ptr >> 32, rec_ptr);
};

bitfield ForkFlags {
    fork_number : 4;
    has_image   : 1;
    has_data    : 1;
    will_init   : 1;
    same_rel    : 1;
};

enum RmgrId: u8 {
    Xlog              = 0,
    Transaction       = 1,
    Storage           = 2,
    Clog              = 3,
    Database          = 4,
    Tablespace        = 5,
    MultiXact         = 6,
    RelMap            = 7,
    Standby           = 8,
    Heap2             = 9,
    Heap              = 10,
    Btree             = 11,
    Hash              = 12,
    Gin               = 13,
    Gist              = 14,
    Sequence          = 15,
    Spgist            = 16,
    Brin              = 17,
    CommitTs          = 18,
    ReplicationOrigin = 19,
    Generic           = 20,
    LogicalMsg        = 21,
};

bitfield ImageInfoFlags {
    has_hole    : 1;
    apply       : 1;
    compress_pglz : 1;
    compress_lz4 : 1;
    compress_zstd : 1;
    padding     : 3;
};

struct XLogRecordBlockCompressHeader {
    u16 hole_length;
};

struct XLogRecordBlockImageHeader {
    u16 length;
    u16 hole_offset;
    ImageInfoFlags bimg_info;

    // BKPIMAGE_HAS_HOLE && BKPIMAGE_COMPRESSED
    if ((bimg_info.has_hole == 1) &&
        ((bimg_info.compress_pglz == 1) ||
         (bimg_info.compress_lz4 == 1) ||
         (bimg_info.compress_zstd == 1))) {
        XLogRecordBlockCompressHeader compress_header;
    }
};

// XLog Record //

struct BlockHeader {
    u8 id;
    ForkFlags fork_flags;
    u16 data_length;
    if (fork_flags.has_image == 1) {
        XLogRecordBlockImageHeader image_header;
    }
    if (fork_flags.same_rel == 0) {
        RelFileLocator rel_file_locator;
    }
    BlockNumber block_number;
};

struct BlockData {
  // TODO: More precise block content?
  u8 block_content[parent.block_headers[current_block].data_length];
  current_block = current_block + 1;
};

bitfield XLogRecordInfoFlags {
    special_rel_update : 1;
    check_consistency  : 1;
    reserved           : 2;
    rmgr_info          : 4;
};

struct MainDataHeader {
    u8 id;
    if (id == XLR_BLOCK_ID_DATA_SHORT) {
      u8 data_length;
    } else if (id == XLR_BLOCK_ID_DATA_LONG) {
      u32 data_length;
    }
};

// Main data //

struct xl_standby_lock {
  TransactionId xid;
  Oid dbOid;
  Oid relOid;
};

struct xl_standby_locks {
  u32 nlocks;
  xl_standby_lock locks[nlocks];
};

struct xl_running_xacts {
  u32 xcnt;
  u32 subxcnt;
  bool subxid_overflow;
  padding[3];
  TransactionId nextXid;
  TransactionId oldestRunningXid;
  TransactionId latestCompletedXid;
  TransactionId xids[xcnt + subxcnt];
};

struct SharedInvalCatcacheMsg {
  Oid dbId;
  u32 hashValue;
};

struct SharedInvalCatalogMsg {
  Oid dbId;
  Oid catId;
};

struct SharedInvalRelcacheMsg {
  Oid dbId;
  Oid relId;
};

struct SharedInvalSmgrMsg {
  s8 backend_hi;
  u16 backend_lo;
  RelFileLocator rlocator;
};

struct SharedInvalRelmapMsg {
  Oid dbId;
};

struct SharedInvalSnapshotMsg {
  Oid dbId;
  Oid relId;
};

struct SharedInvalRelSyncMsg {
  Oid dbId;
  Oid relid;
};

struct SharedInvalidationMessage {
  s8 id;
  match (id) {
    (SHAREDINVALCATALOG_ID): SharedInvalCatalogMsg cat;
    (SHAREDINVALRELCACHE_ID): SharedInvalRelcacheMsg rc;
    (SHAREDINVALSMGR_ID): SharedInvalSmgrMsg sm;
    (SHAREDINVALRELMAP_ID): SharedInvalRelmapMsg rm;
    (SHAREDINVALSNAPSHOT_ID): SharedInvalSnapshotMsg sn;
    (SHAREDINVALRELSYNC_ID): SharedInvalRelSyncMsg rs;
  }
};

struct xl_invalidations {
  Oid dbId;
  Oid tsId;
  bool relcacheInitFileInval;
  u32 nmsgs;
  SharedInvalidationMessage msgs[nmsgs];
};

struct CheckPoint
{
  XLogRecPtr  redo;
  TimeLineID  ThisTimeLineID;
  TimeLineID  PrevTimeLineID;
  bool    fullPageWrites;
  padding[3];
  u32     wal_level;
  FullTransactionId nextXid;
  Oid     nextOid;
  MultiXactId nextMulti;
  MultiXactOffset nextMultiOffset;
  TransactionId oldestXid;
  Oid     oldestXidDB;
  MultiXactId oldestMulti;
  Oid     oldestMultiDB;
  padding[4];
  pg_time_t time;
  TransactionId oldestCommitTsXid;
  TransactionId newestCommitTsXid;
  TransactionId oldestActiveXid;
};

struct xl_parameter_change {
  u32 MaxConnections;
  u32 max_worker_processes;
  u32 max_wal_senders;
  u32 max_prepared_xacts;
  u32 max_locks_per_xact;
  u32 wal_level;
  bool wal_log_hints;
  bool track_commit_timestamp;
};

struct xl_restore_point {
  TimestampTz rp_time;
  char rp_name[64];
};

struct xl_overwrite_contrecord {
  XLogRecPtr overwritten_lsn;
  TimestampTz overwrite_time;
};

struct xl_end_of_recovery {
  TimestampTz end_time;
  TimeLineID ThisTimeLineID;
  TimeLineID PrevTimeLineID;
  u32 wal_level;
};

struct xl_xact_assignment {
  TransactionId xtop;
  u32 nsubxacts;
  TransactionId xsub[nsubxacts];
};

struct xl_xact_xinfo {
  u32 xinfo;
};

struct xl_xact_dbinfo {
  Oid dbId;
  Oid tsId;
};

struct xl_xact_subxacts {
  u32 nsubxacts;
  TransactionId subxacts[nsubxacts];
};

struct xl_xact_relfilelocators {
  u32 nrels;
  RelFileLocator xlocators[nrels];
};

struct xl_xact_stats_item {
  u32 kind;
  Oid dboid;
  u32 objid_lo;
  u32 objid_hi;
};

struct xl_xact_stats_items {
  u32 nitems;
  xl_xact_stats_item items[nitems];
};

struct xl_xact_invals {
  u32 nmsgs;
  SharedInvalidationMessage msgs[nmsgs];
};

struct xl_xact_twophase {
  TransactionId xid;
};

struct xl_xact_origin {
  XLogRecPtr origin_lsn;
  TimestampTz origin_timestamp;
};

struct xl_xact_commit {
  TimestampTz xact_time;

  if ((rmgr_info & XLOG_XACT_HAS_INFO) != 0) {
    xl_xact_xinfo xinfo;
    if ((xinfo.xinfo & XACT_XINFO_HAS_DBINFO) != 0) {
      xl_xact_dbinfo dbinfo;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_SUBXACTS) != 0) {
      xl_xact_subxacts subxacts;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_RELFILELOCATORS) != 0) {
      xl_xact_relfilelocators relfilelocators;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_DROPPED_STATS) != 0) {
      xl_xact_stats_items stats_items;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_INVALS) != 0) {
      xl_xact_invals invals;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_TWOPHASE) != 0) {
      xl_xact_twophase twophase;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_ORIGIN) != 0) {
      xl_xact_origin origin;
    }
  }
};

struct xl_xact_abort {
  TimestampTz xact_time;
  if ((rmgr_info & XLOG_XACT_HAS_INFO) != 0) {
    xl_xact_xinfo xinfo;
    if ((xinfo.xinfo & XACT_XINFO_HAS_DBINFO) != 0) {
      xl_xact_dbinfo dbinfo;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_SUBXACTS) != 0) {
      xl_xact_subxacts subxacts;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_RELFILELOCATORS) != 0) {
      xl_xact_relfilelocators relfilelocators;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_DROPPED_STATS) != 0) {
      xl_xact_stats_items stats_items;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_TWOPHASE) != 0) {
      xl_xact_twophase twophase;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_ORIGIN) != 0) {
      xl_xact_origin origin;
    }
  }
};

struct xl_xact_prepare {
  u32 magic;
  u32 total_len;
  TransactionId xid;
  Oid database;
  TimestampTz prepared_at;
  Oid owner;
  s32 nsubxacts;
  s32 ncommitrels;
  s32 nabortrels;
  s32 ncommitstats;
  s32 nabortstats;
  s32 ninvalmsgs;
  bool initfileinval;
  u16 gidlen;
  XLogRecPtr origin_lsn;
  TimestampTz origin_timestamp;
};

struct xl_heap_header {
  u16 t_infomask2;
  u16 t_infomask;
  u8 t_hoff;
};

struct xl_heap_insert {
  OffsetNumber offnum;
  u8 flags;
};

struct xl_heap_delete {
  TransactionId xmax;
  OffsetNumber offnum;
  u8 infobits_set;
  u8 flags;
};

struct xl_heap_update {
  TransactionId old_xmax;
  OffsetNumber old_offnum;
  u8 old_infobits_set;
  u8 flags;
  TransactionId new_xmax;
  OffsetNumber new_offnum;
};

struct xl_heap_truncate {
  Oid dbId;
  u32 nrelids;
  u8 flags;
  Oid relids[nrelids];
};

struct xl_heap_lock {
  TransactionId xmax;
  OffsetNumber offnum;
  u8 infobits_set;
  u8 flags;
};

struct xl_heap_lock_updated {
  TransactionId xmax;
  OffsetNumber offnum;
  u8 infobits_set;
  u8 flags;
};

struct xl_heap_confirm {
  OffsetNumber offnum;
};

struct xl_heap_inplace {
  OffsetNumber offnum;
  Oid dbId;
  Oid tsId;
  bool relcacheInitFileInval;
  u32 nmsgs;
  SharedInvalidationMessage msgs[nmsgs];
};

struct xl_heap_visible {
  TransactionId snapshotConflictHorizon;
  u8 flags;
};

struct xl_heap_new_cid {
  TransactionId top_xid;
  CommandId cmin;
  CommandId cmax;
  CommandId combocid;
  RelFileLocator target_locator;
  ItemPointerData target_tid;
};

struct xl_heap_rewrite_mapping {
  TransactionId mapped_xid;
  Oid mapped_db;
  Oid mapped_rel;
  u64 offset;
  u32 num_mappings;
  XLogRecPtr start_lsn;
};

struct xl_multi_insert_tuple {
  u16 datalen;
  u16 t_infomask2;
  u16 t_infomask;
  u8 t_hoff;
  u8 tuple_data[datalen];
};

struct xl_heap_multi_insert {
  u8 flags;
  u16 ntuples;
  OffsetNumber offsets[ntuples];
};

struct xlhp_freeze_plan {
  TransactionId xmax;
  u16 t_infomask2;
  u16 t_infomask;
  u8 frzflags;
  u16 ntuples;
};

struct xlhp_freeze_plans {
  u16 nplans;
  xlhp_freeze_plan plans[nplans];
};

struct xlhp_prune_items {
  u16 ntargets;
  OffsetNumber data[ntargets];
};

struct xl_heap_prune {
  u8 reason;
  u8 flags;
  if (flags & XLHP_HAS_CONFLICT_HORIZON) {
    TransactionId conflict_horizon;
  }
};

struct xl_btree_metadata
{
	u32		version;
	BlockNumber root;
	u32		level;
	BlockNumber fastroot;
	u32		fastlevel;
	u32		last_cleanup_num_delpages;
	bool		allequalimage;
};

struct xl_btree_insert
{
	OffsetNumber offnum;

	/* POSTING SPLIT OFFSET FOLLOWS (INSERT_POST case) */
	/* NEW TUPLE ALWAYS FOLLOWS AT THE END */
};

struct xl_btree_split
{
	u32		level;			/* tree level of page being split */
	OffsetNumber firstrightoff; /* first origpage item on rightpage */
	OffsetNumber newitemoff;	/* new item's offset */
	u16		postingoff;		/* offset inside orig posting tuple */
};

struct xl_btree_dedup
{
	u16		nintervals;

	/* DEDUPLICATION INTERVALS FOLLOW */
};

struct xl_btree_reuse_page
{
	RelFileLocator locator;
	BlockNumber block;
	FullTransactionId snapshotConflictHorizon;
	bool		isCatalogRel;	/* to handle recovery conflict during logical decoding on standby */
};

struct xl_btree_vacuum
{
	u16		ndeleted;
	u16		nupdated;
};

struct xl_btree_delete
{
	TransactionId snapshotConflictHorizon;
	u16		ndeleted;
	u16		nupdated;
	bool		isCatalogRel;	/* to handle recovery conflict during logical
								 * decoding on standby */
};

struct xl_btree_update
{
	u16		ndeletedtids;

	/* POSTING LIST uint16 OFFSETS TO A DELETED TID FOLLOW */
};

struct xl_btree_mark_page_halfdead
{
	OffsetNumber poffset;		/* deleted tuple id in parent page */

	/* information needed to recreate the leaf page: */
	BlockNumber leafblk;		/* leaf block ultimately being deleted */
	BlockNumber leftblk;		/* leaf block's left sibling, if any */
	BlockNumber rightblk;		/* leaf block's right sibling */
	BlockNumber topparent;		/* topmost internal page in the subtree */
};

struct xl_btree_unlink_page
{
	BlockNumber leftsib;		/* target block's left sibling, if any */
	BlockNumber rightsib;		/* target block's right sibling */
	u32		level;			/* target block's level */
	FullTransactionId safexid;	/* target block's BTPageSetDeleted() XID */

	BlockNumber leafleftsib;
	BlockNumber leafrightsib;
	BlockNumber leaftopparent;	/* next child down in the subtree */
};

struct xl_btree_unlink_page_meta : xl_btree_unlink_page
{
	xl_btree_metadata xl_btree_metadata;
};

struct xl_btree_newroot
{
	BlockNumber rootblk;		/* location of new root (redundant with blk 0) */
	u32		level;			/* its tree level */
};

struct MainData {
    u8 info = rmgr_info & ~XLR_INFO_MASK;
    auto start_address = $;
    match (rmgr_id) {
      (RmgrId::Xlog): {
        match (info) {
          (XLOG_PARAMETER_CHANGE): xl_parameter_change xl_parameter_change;
          (XLOG_RESTORE_POINT): xl_restore_point xl_restore_point;
          (XLOG_OVERWRITE_CONTRECORD): xl_overwrite_contrecord xl_overwrite_contrecord;
          (XLOG_END_OF_RECOVERY): xl_end_of_recovery xl_end_of_recovery;
          (XLOG_CHECKPOINT_REDO): u32 wal_level;
          (XLOG_CHECKPOINT_ONLINE): CheckPoint checkpoint;
        }
      }
      (RmgrId::Transaction): {
        match (info & XLOG_XACT_OPMASK) {
          (XLOG_XACT_COMMIT): xl_xact_commit xl_xact_commit;
          (XLOG_XACT_ABORT): xl_xact_abort xl_xact_abort;
          (XLOG_XACT_PREPARE): xl_xact_prepare xl_xact_prepare;
          (XLOG_XACT_ASSIGNMENT): xl_xact_assignment xl_xact_assignment;
          (XLOG_XACT_INVALIDATIONS): xl_xact_invals xl_xact_invals;
        }
      }
      (RmgrId::Storage): { }
      (RmgrId::Clog): { }
      (RmgrId::Database): { }
      (RmgrId::Tablespace): { }
      (RmgrId::MultiXact): { }
      (RmgrId::RelMap): { }
      (RmgrId::Standby): {
        match (info) {
          (XLOG_STANDBY_LOCK): xl_standby_locks xl_standby_locks;
          (XLOG_RUNNING_XACTS): xl_running_xacts xl_running_xacts;
          (XLOG_INVALIDATIONS): xl_invalidations xl_invalidations;
        }
      }
      (RmgrId::Heap): {
        match (info & XLOG_HEAP_OPMASK) {
          (XLOG_HEAP_INSERT): xl_heap_insert xl_heap_insert;
          (XLOG_HEAP_DELETE): xl_heap_delete xl_heap_delete;
          (XLOG_HEAP_UPDATE): xl_heap_update xl_heap_update;
          (XLOG_HEAP_TRUNCATE): xl_heap_truncate xl_heap_truncate;
          (XLOG_HEAP_HOT_UPDATE): xl_heap_update xl_heap_hot_update;
          (XLOG_HEAP_CONFIRM): xl_heap_confirm xl_heap_confirm;
          (XLOG_HEAP_LOCK): xl_heap_lock xl_heap_lock;
          (XLOG_HEAP_INPLACE): xl_heap_inplace xl_heap_inplace;
        }
      }
      (RmgrId::Heap2): {
        match (info & XLOG_HEAP2_OPMASK) {
          (XLOG_HEAP2_REWRITE): xl_heap_rewrite_mapping xl_heap_rewrite_mapping;
          (XLOG_HEAP2_PRUNE_ON_ACCESS | XLOG_HEAP2_PRUNE_VACUUM_SCAN | XLOG_HEAP2_PRUNE_VACUUM_CLEANUP): xl_heap_prune xl_heap_prune;
          (XLOG_HEAP2_VISIBLE): xl_heap_visible xl_heap_visible;
          (XLOG_HEAP2_MULTI_INSERT): xl_heap_multi_insert xl_heap_multi_insert;
          (XLOG_HEAP2_LOCK_UPDATED): xl_heap_lock_updated xl_heap_lock_updated;
          (XLOG_HEAP2_NEW_CID): xl_heap_new_cid xl_heap_new_cid;
        }
      }
      (RmgrId::Btree): {
        match (info) {
		      (XLOG_BTREE_INSERT_LEAF | XLOG_BTREE_INSERT_UPPER | XLOG_BTREE_INSERT_META | XLOG_BTREE_INSERT_POST): xl_btree_insert xl_btree_insert;
		      (XLOG_BTREE_SPLIT_L | XLOG_BTREE_SPLIT_R): xl_btree_split xl_btree_split;
		      (XLOG_BTREE_DEDUP): xl_btree_dedup xl_btree_dedup;
		      (XLOG_BTREE_VACUUM): xl_btree_vacuum xl_btree_vacuum;
		      (XLOG_BTREE_DELETE): xl_btree_delete xl_btree_delete;
		      (XLOG_BTREE_MARK_PAGE_HALFDEAD): xl_btree_mark_page_halfdead xl_btree_mark_page_halfdead;
		      (XLOG_BTREE_UNLINK_PAGE): xl_btree_unlink_page xl_btree_unlink_page;
		      (XLOG_BTREE_UNLINK_PAGE_META): xl_btree_unlink_page_meta xl_btree_unlink_page_meta;
		      (XLOG_BTREE_NEWROOT): xl_btree_newroot xl_btree_newroot;
		      (XLOG_BTREE_REUSE_PAGE): xl_btree_reuse_page xl_btree_reuse_page;
		      // (XLOG_BTREE_META_CLEANUP): ;
        }
      }
      (RmgrId::Hash): { }
      (RmgrId::Gin): { }
      (RmgrId::Gist): { }
      (RmgrId::Sequence): { }
      (RmgrId::Spgist): { }
      (RmgrId::Brin): { }
      (RmgrId::CommitTs): { }
      (RmgrId::ReplicationOrigin): { }
      (RmgrId::Generic): { }
      (RmgrId::LogicalMsg): { }
    }
    padding[main_data_length - ($ - start_address)];
} [[inline]];

struct XLogRecord {
    auto start_address = $;
    // Did we reach the end of a page?
    if ($ % globalPageSize == 0) {
      break;
    }

    u32 xl_tot_len;
    if (xl_tot_len == 0) {
      break;
    }

    TransactionId xl_xid;
    XLogRecPtr xl_prev;
    XLogRecordInfoFlags xl_info;
    RmgrId xl_rmid;
    padding[2];
    u32 xl_crc;

    // Headers
    BlockHeader block_headers[while(std::mem::read_unsigned($, 1) <= XLR_MAX_BLOCK_ID)];
    MainDataHeader main_data_header;

    // Data block
    current_block = 0;
    BlockData block_data[std::core::member_count(block_headers)];

    // Main data
    rmgr_id = xl_rmid;
    rmgr_info = xl_info.rmgr_info << 4;

    main_data_length = main_data_header.data_length;
    MainData main_data;
    if ($ - start_address < xl_tot_len) {
      std::print("Invalid record size {} < {}", $ - start_address, xl_tot_len);
      break;
    }
    std::mem::AlignTo<8>;
};


// XLog Page //

bitfield XLogPageInfoFlags {
    first_is_contrecord : 1;
    long_header         : 1;
    bkp_removable       : 1;
    first_is_overwrite_contrecord : 1;
    reserved            : 12;
};

struct XLogPage {
  // Standard page header
  u16 xlp_magic;
  if (xlp_magic == 0) {
    break;
  }

  XLogPageInfoFlags xlp_info;
  TimeLineID xlp_tli;
  XLogRecPtr xlp_pageaddr;
  u32 xlp_rem_len;
  padding[4];

  // Long page header
  if (xlp_info.long_header) {
    u64 xlp_sysid;
    u32 xlp_seg_size [[format("type::impl::size_formatter")]];;;
    u32 xlp_xlog_blcksz;
    globalPageSize = xlp_xlog_blcksz;
  }

  XLogRecord records[while(true)];
} [[fixed_size(globalPageSize)]];

// XLogPage page[while (!std::mem::eof())] @ 0x00;
// XLogPage page[while(std::mem::read_unsigned($, 1) == 0x00)] @ 0x00;
XLogPage page @ 0x00;
