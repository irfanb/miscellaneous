#pragma once

#include <string>
#include <type_traits>
#include <variant>
#include <vector>
#include "absl/log/log.h"

class Operator {
    std::string m_value;

public:
    Operator( const std::string &value );
    const std::string toString() const;
};

class Null {
protected:
public:
    Null();
    virtual const std::string toString() const;
};

class NumberAtom {
protected:
    int m_value;

public:
    NumberAtom();
    NumberAtom( const std::string &val );
    virtual const std::string toString() const;
};

class StringAtom {
protected:
    std::string m_value;

public:
    StringAtom( const std::string &val );
    virtual const std::string toString() const;
};

class IdentifierAtom : public StringAtom {
public:
    IdentifierAtom( const std::string &val );
    const std::string toString() const override;
};

class SymbolAtom : public StringAtom {
public:
    SymbolAtom( const std::string &val );
    const std::string toString() const override;
};

/*
typedef union {
    const char* id;
    int num;
    std::vector< member > sequence;
} mysemantictype;
*/

class mysemantictype {
    bool m_isList = false;
public:
    mysemantictype() {
	    //LOG(INFO) <<("default constructor invoked");
    }
    mysemantictype(const mysemantictype& copyMe) : m_isList( copyMe.m_isList ), m_value( copyMe.m_value ) {
	//LOG( INFO ) << "copy constructor invoked address of copyMe is " << &copyMe << " and string representation is " << copyMe.toString();
    }
    using Sequence = std::vector<mysemantictype>;
    std::string toString() const {
        std::string r;
        const auto valueToString = [this, &r]( auto &&arg ) {
            using T = std::decay_t<decltype( arg )>;
            if constexpr ( std::is_same_v<T, int> ) {
                r = "";
            } else if constexpr ( std::is_same_v<T, NumberAtom> ) {
                r = arg.toString();
            } else if constexpr ( std::is_same_v<T, Null> ) {
                r = arg.toString();
            } else if constexpr ( std::is_same_v<T, IdentifierAtom> ) {
                r = arg.toString();
            } else if constexpr ( std::is_same_v<T, SymbolAtom> ) {
                r = arg.toString();
            } else if constexpr ( std::is_same_v<T, StringAtom> ) {
                r = arg.toString();
            } else if constexpr ( std::is_same_v<T, Operator> ) {
                r = arg.toString();
            } else if constexpr ( std::is_same_v<T, Sequence> ) {
		    if (m_isList) r+= "(";
                for ( const auto &a : arg ) {
                    r += a.toString();
                }
		    if (m_isList) r+= ")";
                // r += "members of size ";
                // r += std::to_string( arg.size() );
            } else {
                r += "plop";
            }
        };
        std::visit( valueToString, m_value );
        return r;
    }
    const IdentifierAtom &getIdentifierAtom() const {
        return std::get<IdentifierAtom>( m_value );
    };
    void setIdentifierAtom( const IdentifierAtom &newValue ) {
        m_value = newValue;
    };
    const SymbolAtom &getSymbolAtom() const {
        return std::get<SymbolAtom>( m_value );
    };
    void setSymbolAtom( const SymbolAtom &newValue ) { m_value = newValue; };
    const NumberAtom &getNumberAtom() const {
        return std::get<NumberAtom>( m_value );
    };
    void setNumberAtom( const NumberAtom &newValue ) { m_value = newValue; };
    void setNull() { m_value = Null(); };
    const std::vector<mysemantictype> &getSequence() const {
        return std::get<std::vector<mysemantictype>>( m_value );
    };
    void setSequence( const std::vector<mysemantictype> &newValue ) {
        m_value = newValue;
    };
    void setList( const std::vector<mysemantictype> &newValue ) {
        m_value = newValue;
	m_isList = true;
    };
    void setEmptySequence() { m_value = std::vector<mysemantictype>(); }
    void setOperator( const std::string &newValue ) {
        m_value = Operator( newValue );
    };
    void setStringAtom( const char *newValue ) {
        m_value = StringAtom( newValue );
    };
    std::variant<Null, NumberAtom, Operator, IdentifierAtom, SymbolAtom,
                 StringAtom, std::vector<mysemantictype>>
        m_value;
};

#define YYSTYPE mysemantictype
