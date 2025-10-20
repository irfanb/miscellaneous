typedef union {
	const char* id;
	int num;
} mysemantictype;

#define YYSTYPE mysemantictype
