#pragma once

#include <vector>
#include <string>
#include <variant>
#include <type_traits>

class Operator {
    std::string m_value;
public:
    Operator(const std::string& value) : m_value( value ) {}
    const std::string& toString() const {
        return m_value;
    }
};

class StringAtom {
protected:
    std::string m_value;
public:
    StringAtom(const std::string& val) { m_value = val; }
    virtual const std::string toString() const {
        return m_value;
    }
};

class IdentifierAtom : public StringAtom {
public:
    IdentifierAtom(const std::string& val) : StringAtom(val) {}
    const std::string toString() const override {
        return m_value;
    }
};

class SymbolAtom : public StringAtom {
public:
    SymbolAtom(const std::string& val) : StringAtom(val) {}
    const std::string toString() const override {
        return std::string(":") + m_value;
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
                    r = std::to_string( arg );
                } else if constexpr ( std::is_same_v< T, std::string > ) {
                    r = arg + ", ";
                } else if constexpr ( std::is_same_v< T, IdentifierAtom > ) {
                    r = arg.toString() + ", ";
                } else if constexpr ( std::is_same_v< T, SymbolAtom > ) {
                    r = arg.toString() + ", ";
                } else if constexpr ( std::is_same_v< T, StringAtom > ) {
                    r = arg.toString() + ", ";
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
    const IdentifierAtom& m_id() const {
        return std::get<IdentifierAtom>(m_value);
    };
    void m_id(const IdentifierAtom& newValue) {
        m_value = newValue;
    };
    const SymbolAtom& getSymbolAtom() const {
        return std::get<SymbolAtom>(m_value);
    };
    void setSymbolAtom(const SymbolAtom& newValue) {
        m_value = newValue;
    };
    int m_num() const {
        return std::get<int>(m_value);
    };
    void m_num( int newValue ) {
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
    std::variant< std::string, int, Operator, IdentifierAtom, SymbolAtom, StringAtom, std::vector< mysemantictype> > m_value;
};

#define YYSTYPE mysemantictype
