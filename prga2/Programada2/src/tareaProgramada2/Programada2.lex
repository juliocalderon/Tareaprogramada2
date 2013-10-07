
package tareaProgramada2;

import java_cup.runtime.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import tareaProgramada2.Programada2Sym;
import static tareaProgramada2.Programada2Sym.*;

%%

%class Programada2Lex

%unicode
%line
%column

// %public
%final
// %abstract

%cupsym tareaProgramada2.Programada2Sym
%cup
// %cupdebug

%init{
	this.tokensList = new ArrayList();
%init}

%{

private ArrayList tokensList; /* 

private void writeOutputFile() throws IOException { /* our method for writing the output file */
	String filename = "file.out";
	BufferedWriter out = new BufferedWriter(new FileWriter(filename));
	for (String s:this.tokensList) {
		out.write(s + "\n");
	}
	out.close();
}

%}











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

{ANY}		{	return sym(ANY); }

