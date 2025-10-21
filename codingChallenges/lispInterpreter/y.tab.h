#pragma once

#include <vector>
#include <string>
#include <variant>
#include <type_traits>

class member {
};

class Operator {
public:
	Operator(int) {}
};

/*
typedef union {
	const char* id;
	int num;
	std::vector< member > sequence;
} mysemantictype;
*/

using sequence = std::vector< member >;
class mysemantictype {
public:
	std::string toString() const {
		std::string r;
		const auto valueToString =
			[&r](auto&& arg){
				using T = std::decay_t<decltype(arg)>;
				if constexpr ( std::is_same_v< T, int > ) {
					r = std::to_string( arg );
				} else if constexpr ( std::is_same_v< T, std::string > ) {
					r = arg;
				} else if constexpr ( std::is_same_v< T, Operator > ) {
					r = "operator";
				} else {
					for (const auto& a : arg) {
					}
					r += "members of size ";
					r += std::to_string( arg.size() );
				}
				};
		std::visit(valueToString, m_value);
		return r;
	}
	const std::string& m_id() const {
		return std::get<std::string>(m_value);
	};
	void m_id(const std::string& newValue) {
		m_value = newValue;
	};
	int m_num() const {
		return std::get<int>(m_value);
	};
	void m_num( int newValue ) {
		m_value = newValue;
	};
	const std::vector< member >& m_sequence() const {
		return std::get< std::vector< member > >(m_value);
	};
	void m_sequence(const std::vector< member >& newValue) {
		m_value = newValue;
	};
	void setOperator(const int newValue) {
		m_value = Operator(newValue);
	};
	std::variant< std::string, int, Operator, sequence > m_value;
};

#define YYSTYPE mysemantictype
