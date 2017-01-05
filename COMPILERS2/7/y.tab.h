
typedef union
#ifdef __cplusplus
	YYSTYPE
#endif
 {
   int inttype;
   char *str_ptr;
   struct sem_rec *rec_ptr;
   struct id_entry *id_ptr;
   } YYSTYPE;
extern YYSTYPE yylval;
# define ID 257
# define CON 258
# define STR 259
# define CHAR 260
# define ELSE 261
# define DOUBLE 262
# define FOR 263
# define IF 264
# define INT 265
# define RESERVED 266
# define RETURN 267
# define WHILE 268
# define DO 269
# define CONTINUE 270
# define BREAK 271
# define GOTO 272
# define LVAL 273
# define SET 274
# define SETOR 275
# define SETXOR 276
# define SETAND 277
# define SETLSH 278
# define SETRSH 279
# define SETADD 280
# define SETSUB 281
# define SETMUL 282
# define SETDIV 283
# define SETMOD 284
# define OR 285
# define AND 286
# define BITOR 287
# define BITXOR 288
# define BITAND 289
# define EQ 290
# define NE 291
# define GT 292
# define GE 293
# define LT 294
# define LE 295
# define LSH 296
# define RSH 297
# define ADD 298
# define SUB 299
# define MUL 300
# define DIV 301
# define MOD 302
# define UNARY 303
# define NOT 304
# define COM 305
