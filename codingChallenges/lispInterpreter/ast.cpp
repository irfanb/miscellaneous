#include "ast.h"

Operator::Operator( const std::string &value ) : m_value( value ) {}
const std::string Operator::toString() const {
    return std::string( "OperatorAtom " ) + m_value;
}

Null::Null() {}
const std::string Null::toString() const { return "NullThing "; }

NumberAtom::NumberAtom() { m_value = 0; }
NumberAtom::NumberAtom( const std::string &val ) { m_value = std::stoi( val ); }
const std::string NumberAtom::toString() const {
    return std::string( " " ) + std::to_string( m_value );
}

StringAtom::StringAtom( const std::string &val ) { m_value = val; }
const std::string StringAtom::toString() const {
    return std::string( " " ) + m_value;
}

IdentifierAtom::IdentifierAtom( const std::string &val ) : StringAtom( val ) {}
const std::string IdentifierAtom::toString() const {
    return std::string( " " ) + m_value;
}

SymbolAtom::SymbolAtom( const std::string &val ) : StringAtom( val ) {}
const std::string SymbolAtom::toString() const {
    return std::string( " " ) + std::string( "" ) + m_value;
}
