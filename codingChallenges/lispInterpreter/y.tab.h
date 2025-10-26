#pragma once

#include <vector>
#include <string>
#include <variant>
#include <type_traits>

class Operator {
    std::string m_value;
public:
    Operator(const std::string& value) : m_value( value ) {}
    const std::string toString() const {
        return std::string("OperatorAtom ") + m_value;
    }
};

class NumberAtom {
protected:
    int m_value;
public:
    NumberAtom() { m_value = 0; }
    NumberAtom(const std::string& val) { m_value = std::stoi(val); }
    virtual const std::string toString() const {
        return std::string("NumberAtom ") + std::to_string( m_value );
    }
};

class StringAtom {
protected:
    std::string m_value;
public:
    StringAtom(const std::string& val) { m_value = val; }
    virtual const std::string toString() const {
        return std::string("StringAtom ") + m_value;
    }
};

class IdentifierAtom : public StringAtom {
public:
    IdentifierAtom(const std::string& val) : StringAtom(val) {}
    const std::string toString() const override {
        return std::string("IdentifierAtom ") + m_value;
    }
};

class SymbolAtom : public StringAtom {
public:
    SymbolAtom(const std::string& val) : StringAtom(val) {}
    const std::string toString() const override {
        return std::string("SymbolAtom ") + std::string(":") + m_value;
    }
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
    std::string toString() const {
        std::string r;
        const auto valueToString =
            [&r](auto&& arg){
                using T = std::decay_t<decltype(arg)>;
                if constexpr ( std::is_same_v< T, int > ) {
                    r = "";
		} else if constexpr ( std::is_same_v< T, NumberAtom > ) {
                    r = arg.toString();
                } else if constexpr ( std::is_same_v< T, IdentifierAtom > ) {
                    r = arg.toString();
                } else if constexpr ( std::is_same_v< T, SymbolAtom > ) {
                    r = arg.toString();
                } else if constexpr ( std::is_same_v< T, StringAtom > ) {
                    r = arg.toString();
                } else if constexpr ( std::is_same_v< T, Operator > ) {
                    r = arg.toString();
                } else {
                    for (const auto& a : arg) {
                        r+= a.toString();
                    }
                    r += "members of size ";
                    r += std::to_string( arg.size() );
                }
                };
        std::visit(valueToString, m_value);
        return r;
    }
    const IdentifierAtom& getIdentifierAtom() const {
        return std::get<IdentifierAtom>(m_value);
    };
    void setIdentifierAtom(const IdentifierAtom& newValue) {
        m_value = newValue;
    };
    const SymbolAtom& getSymbolAtom() const {
        return std::get<SymbolAtom>(m_value);
    };
    void setSymbolAtom(const SymbolAtom& newValue) {
        m_value = newValue;
    };
    const NumberAtom& getNumberAtom() const {
        return std::get<NumberAtom>(m_value);
    };
    void setNumberAtom( const NumberAtom& newValue ) {
        m_value = newValue;
    };
    const std::vector< mysemantictype >& m_sequence() const {
        return std::get< std::vector< mysemantictype > >(m_value);
    };
    const std::vector< mysemantictype >& getSequence() const {
        return m_sequence();
    };
    void setSequence(const std::vector< mysemantictype >& newValue) {
        m_value = newValue;
    };
    void setEmptySequence() {
        m_value = std::vector< mysemantictype >();
    }
    void setOperator(const std::string& newValue) {
        m_value = Operator(newValue);
    };
    void setStringAtom(const char* newValue) {
        m_value = StringAtom(newValue);
    };
    std::variant< NumberAtom, Operator, IdentifierAtom, SymbolAtom, StringAtom, std::vector< mysemantictype> > m_value;
};

#define YYSTYPE mysemantictype
