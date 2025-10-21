#pragma once

#include <vector>
#include <string>

class member {
};

/*
typedef union {
	const char* id;
	int num;
	std::vector< member > sequence;
} mysemantictype;
*/

class mysemantictype {
public:
	std::string m_id;
	int m_num;
	std::vector< member > m_sequence;
	class member m_member;
};

#define YYSTYPE mysemantictype
