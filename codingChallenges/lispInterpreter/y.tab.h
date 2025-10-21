#pragma once

#include <vector>
#include <string>
#include <variant>
#include <type_traits>

class member {
};

class Operator {
	std::string m_value;
public:
	Operator(const std::string& value) : m_value( value ) {}
	const std::string& toString() const {
		return m_value;
	}
};

class StringAtom {
	std::string m_value;
public:
	StringAtom(const std::string& val) { m_value = val; }
	const std::string& toString() const {
		return m_value;
	}
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
					r = std::to_string( arg ) + " int";
				} else if constexpr ( std::is_same_v< T, std::string > ) {
					r = arg + " string";
				} else if constexpr ( std::is_same_v< T, StringAtom > ) {
					r = arg.toString() + " stringatom";
				} else if constexpr ( std::is_same_v< T, Operator > ) {
					r = arg.toString() + " operator";
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
	const std::vector< member >& getSequence() const {
		return m_sequence();
	};
	void m_sequence(const std::vector< member >& newValue) {
		m_value = newValue;
	};
	void setOperator(const std::string& newValue) {
		m_value = Operator(newValue);
	};
	void setStringAtom(const char* newValue) {
		m_value = StringAtom(newValue);
	};
	std::variant< std::string, int, Operator, StringAtom, sequence > m_value;
};

#define YYSTYPE mysemantictype
