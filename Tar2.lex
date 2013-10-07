
package tp2;

import java_cup.runtime.*;
import java.io.IOException;

import tp2.Tar2Sym;
import static tp2.Tar2Sym.*;
import java.io.BufferedWriter;
import java.io.FileWriter;

%%

%class Tar2Lex
%unicode
%line
%column

// %public
%final
// %abstract

%cupsym tp2.Tar2Sym
%cup
// %cupdebug

%init{
	this.tokensList = new ArrayList();
%init}

%{

private ArrayList tokensList; /* aca se guardaran las salidas de los input */

private void writeOutputFile() throws IOException { /* metodo para escribir la entrada final del fichero */
	String filename = "archivosalida.out";
	BufferedWriter out = new BufferedWriter(new FileWriter(filename));
	for (String s:this.tokensList) {
		out.write(s + "\n");
	}
	out.close();
}

%}


TerminadorLinea = \r|\n|\r\n
Espacio = {TerminadorLinea} | [ \t\f]
Identifier  = [a-zA-Z\0,]
Empty=""

%{
	private Symbol sym(int type)
	{
		return sym(type, yytext());
	}

	private Symbol sym(int type, Object value)
	{
		return new Symbol(type, yyline, yycolumn, value);
	}

	private void error()
	throws IOException
	{
		throw new IOException("illegal text at line = "+yyline+", column = "+yycolumn+", text = '"+yytext()+"'");
	}
%}

ANY			=	.

%%
{Identifier}+"("{Identifier}|{Empty}*+")"+"."    {this.tokensList.add(yyline+ yycolumn);}


{ANY}		{	return sym(ANY); }

