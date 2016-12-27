%{

#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <iostream>
#include <string>
#include <string.h>
#include <sstream>
#include <fstream>
#include "fmt/format.h"
using namespace std;

using namespace fmt; 
int outprintint;
extern int yylex();
extern int yyparse();
extern int yylineno; 
extern FILE* yyin;
vector<struct node> nodes; 
vector<string> idlist;
vector<string> constlist;
vector<string> rconstcharlist;
vector<struct ident> iddec;
int label=0;
void showtree();
void showvec(vector<string>& v);
int finddeclar(int s);
struct ident
{
	string type;
	int numinidlist;
	string str;
};
int finddeclar(int s){
	for (int i = 0; i < iddec.size(); ++i)
	{
		if (s==iddec[i].numinidlist)
		{
			return i;
		}
	}
	return -1;
}

struct node
{
	int father;
	string nodetype;
	int child1;
	int child2;
	int child3;
	int child4;
	int otherlistrefer;
	string typespe;
	string asscode;

};
bool trydecid(int idinidlist){
	if (finddeclar(nodes[idinidlist].otherlistrefer)!=-1)
		{
									/* code */
			//cout<<"already define "<<endl;
			return false;
		}
		else
		{
			//cout<<"notfind"<<endl;
			struct ident id={"n",nodes[idinidlist].otherlistrefer};
			iddec.push_back(id);
			return true;
		}
}

void shownode(int i){
	struct node t=nodes[i];
		
	cout<<i<<"\t"<<t.father<<"\t"<<t.nodetype<<'\t'<<t.child1<<'\t'<<t.child2<<'\t'<<t.child3<<'\t'<<t.child4<<endl;
}
void yyerror(const char* s);
int findID(string s){
	for (int i = 0; i < idlist.size(); ++i)
	{
		if (idlist[i].compare(s)==0)
		{
			return i;
		}
	}
	return -1;
}
void setfather(int child,int father)
{
	if (child!=-1)
	{
		nodes[child].father=father;
	}
	
}
void initlistset(char type,int initlist){
	struct node tmp=nodes[initlist];
	if (tmp.child1!=-1)
	{
		/* code */
		initlistset(type,tmp.child1);
	}
	struct  node tmptor=nodes[tmp.child2];
	struct node tmpID=nodes[tmptor.child1];
	int numiniddec=-1;
	for (int i = 0; i < iddec.size(); ++i)
	{
		/* code */
		if (tmpID.otherlistrefer==iddec[i].numinidlist)
		{
			/* code */
			numiniddec=i;

		}
	}
	iddec[numiniddec].type=type;
	cout<<tmpID.typespe<<endl;

	tmpID.typespe=type;
	cout<<tmpID.typespe<<endl;
}
int  findhead(){
	cout<<"heads:"<<endl;
	int head=-1;
	for (int i = 0; i < nodes.size(); ++i)
	{
		if (nodes[i].father==-1)
		{
			shownode(i);
			head=i;
		}
	}
	return head;
}
bool checktype(int numinnode,string type)
{
	if (nodes[numinnode].typespe==type)
	{
		/* code */
		return true;
	}
	return false;
}
bool doubleintcheck(int num1,int num2){

	if (checktype(num1,"INT")&&checktype(num2,"INT"))
	{
		/* code */
		//settype(numd,"INT");
		return true;

	}
	return false;
}
bool doubleboolcheck(int num1,int num2)
{
	if (checktype(num1,"BOOL")&&checktype(num2,"BOOL"))
	{
		/* code */
		//settype(numd,"INT");
		return true;

	}
	return false;
}
int insert(string type,int c1,int c2,int c3,int c4=-1,int c5=-1)
{
	struct node n={-1,type,c1,c2,c3,c4,c5,"n",""};
	

	nodes.push_back(n);
	int now=nodes.size()-1;
	
	setfather(c1,now);
	setfather(c2,now);
	setfather(c3,now);
	setfather(c4,now);
	//cout<<"reduce";
	//shownode(now);
	//showtree();
	//showvec(idlist);
	//findhead();
	return now;
}
void settype(int nodeid,string type){
	nodes[nodeid].typespe=type;
}
void showtree()
{
	for(int i=0;i<nodes.size();i++)
	{
		shownode(i);
	}
	cout<<endl<<endl;
}
void showiddec(){
	for (int i = 0; i < iddec.size(); ++i)
	{
		/* code */
		cout<<iddec[i].type<<'\t'<<iddec[i].numinidlist<<endl;
	}
}
void showtreeshift(string shift,int place){
	if (place>=0)
	{
		struct node nod=nodes[place];
		cout<<shift<<nod.nodetype<<' '<<place;
		if (nod.otherlistrefer!=-1)
		{
			cout<<"\t"<<nod.otherlistrefer;
		}
		
		cout<<"\t"<<nod.typespe;
		if (!nod.asscode.empty())
		{
			cout<<"\n"<<nod.asscode;
		}
		
		//cout<<"\t"<<nod.asscode;
		cout<<endl;
		showtreeshift(shift+"  ",nod.child1);
		showtreeshift(shift+"  ",nod.child2);
		showtreeshift(shift+"  ",nod.child3);
		showtreeshift(shift+"  ",nod.child4);
		
	}
	
}
void showvec(vector<string>& v)
{
	cout<<endl;

	
	for (int i = 0; i < v.size(); ++i)
	{
		cout<<i<<'\t'<<v[i]<<endl;
	}

}
void doubleexpcode(int a$,int a1,int a3,string add)
{
								struct node *t=&nodes[a$];
								struct ident id={"INT",nodes[a$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\n{5} eax,ebx\nmov _t{4},eax\n"
									,nodes[a1].asscode
									,nodes[a3].asscode
									,nodes[a1].otherlistrefer
									,nodes[a3].otherlistrefer
									,nodes[a$].otherlistrefer
									,add);
}
%}

%union {
	int place;
	char* val;
   float fval;
   char typ;
}

%token FNUMBER
%token PLUS MINUS MULT DIV EXPON
%token EOL
%token LB RB LBR RBR LMB RMB
%token INP OUT AUTO BOOL BREAK CHAR CONTINUE FALSE FLOAT INT LONG RETURN TRUE VOID THIS CASE DOUBLE CONST DO ELSE FOR GOTO IF WHILE SEMI EQ 
%token ID CHARCONST
%token NUMBER
%token LOGOR LOGAND  BITOR   BITXOR   BITAND   NOTEQL EQL   BEQ SEQ   LSHIFT RSHIFT PER BE SE
%token COMN
%token PLUPLU MINMIN

%nonassoc lowerelse
%nonassoc ELSE

%right EQ
%left LOGOR
%left LOGAND
%left BITOR
%left BITXOR
%left BITAND
%left NOTEQL EQL
%left BE SE BEQ SEQ
%left LSHIFT RSHIFT
%left  MINUS PLUS
%left  MULT DIV PER

 
%type  <fval>  FNUMBER
%type <place> expr emptyexp unaryexpr postfixexpr baseexpr declaration initlist initdeclarator identifier statement compound-statement  selection-statement iteration-statement jump-statement exprlist sentenlist sentence typespecifermore
%type <typ>	typespecifer

%%

sentenlist:	sentence sentenlist{$$=insert("sentencelist",$1,$2,-1);
								nodes[$$].asscode=format("{0}{1}"
									,nodes[$1].asscode
									,nodes[$2].asscode
									);
							}
			|sentence {$$=insert("sentencelist",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
			;
sentence :	declaration {$$=insert("sentence",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
			|statement {$$=insert("sentence",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
			//|     {$$=insert("NULLsentence",-1,-1,-1);}
			;
statement   :  emptyexp SEMI {$$=insert("exprstmt",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
              |  compound-statement  {$$=insert("compoundstmt",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
              |  selection-statement  {$$=insert("selestmt",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
              |  iteration-statement  {$$=insert("itstmt",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
  			  |  jump-statement  {$$=insert("jumpstmt ",$1,-1,-1);nodes[$$].asscode=nodes[$1].asscode;}
  			  |OUT LB expr RB SEMI  { $$=insert("output ",$3,-1,-1);cout<<"out"<<endl;
  			  		struct node *t=&nodes[$$];
  			  		t->asscode=format("{0}invoke crt_printf,addr szoutput,_t{1}\n"
									,nodes[$3].asscode
									,nodes[$3].otherlistrefer
									
									);
  			  		

  				}
  			  |INP LB identifier RB SEMI {$$=insert("input ",$3,-1,-1);

  					struct node *t=&nodes[$$];
  			  		t->asscode=format("{0}invoke crt_scanf,addr szInput,addr _t{1}\n"
									,nodes[$3].asscode
									,nodes[$3].otherlistrefer
									
									);}
  			  ;
emptyexp 	:exprlist {$$=$1;}
			| 		{$$=insert("nullexpr",-1,-1,-1);}
			;
compound-statement:LBR sentenlist RBR{//cout<<"ss"<<endl;
						$$=insert("compound",$2,-1,-1);
						nodes[$$].asscode=nodes[$2].asscode;
					}
					|LBR RBR{//cout<<"ss"<<endl;
					$$=insert("nullcompou",-1,-1,-1);nodes[$$].asscode="";}
					;
selection-statement   :IF LB  expr  RB  statement   ELSE statement  {$$=insert("IF",$3,$5,$7);cout<<"ifelse"<<endl;
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								//t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}mov eax,_t{3}\ncmp eax,0\nje L{4}\n{1}jmp L{5}\nL{4}:\n{2}L{5}:\n"
									,nodes[$3].asscode
									,nodes[$5].asscode
									,nodes[$7].asscode
									,nodes[$3].otherlistrefer
									,label++
									,label++
									);
						}
                       |IF LB expr RB  statement  %prec lowerelse {$$=insert("IF",$3,$5,-1);cout<<"if"<<endl;
                   				struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								//t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}mov eax,_t{2}\ncmp eax,0\nje L{3}\n{1}L{3}:\n"
									,nodes[$3].asscode
									,nodes[$5].asscode
									,nodes[$3].otherlistrefer
									,label++
									);
							}
                        ;
iteration-statement   : WHILE LB expr RB  statement  {$$=insert("WHILE",$3,$5,-1);
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								//t->otherlistrefer=iddec.size()-1;
								t->asscode=format("L{3}:\n{0}mov eax,_t{2}\ncmp eax,0\nje L{4}\n{1}jmp L{3}\nL{4}:\n"
									,nodes[$3].asscode
									,nodes[$5].asscode
									,nodes[$3].otherlistrefer
									,label++
									,label++
									);
				}
                        | DO  statement   WHILE LB  expr RB  SEMI{$$=insert("DOWHILE",$2,$5,-1);}
                        | FOR LB emptyexp SEMI emptyexp SEMI emptyexp RB statement     {
                        		$$=insert("FOR",$3,$5,$7,$9);
                    			struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								//t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}L{7}:\n{1}mov eax,_t{5}\ncmp eax,0\nje L{8}\n{3}{2}jmp L{7}\nL{8}:\n"
									,nodes[$3].asscode
									,nodes[$5].asscode
									,nodes[$7].asscode
									,nodes[$9].asscode
									,nodes[$3].otherlistrefer
									,nodes[$5].otherlistrefer
									,nodes[$7].otherlistrefer
									,label++
									,label++
									);
							}                    
jump-statement   : CONTINUE SEMI {$$=insert("CONTINUE",-1,-1,-1);}
                   | BREAK SEMI {$$=insert("BREAK",-1,-1,-1);}
                   | RETURN emptyexp SEMI{$$=insert("RETURN",$2,-1,-1);}
declaration	:initlist SEMI{
									
									$$=insert("declaration",$1,-1,-1);
									settype($$,nodes[$1].typespe);
									nodes[$$].asscode=nodes[$1].asscode;

									//initlistset('I',$2);
									//setalliddef($$);
								}
			;
initlist	:typespecifermore initdeclarator  	{
													$$=insert("initlist",$1,$2,-1);
													//settype($1,"t");
													settype($$,nodes[$1].nodetype);
													int iden=nodes[$2].child1;
													int of=nodes[iden].otherlistrefer;
													iddec[of].type=nodes[$1].nodetype;
													nodes[$$].asscode=nodes[$2].asscode;

												}
			|initlist COMN initdeclarator {$$=insert("initlists",$1,$3,-1);
											settype($$,nodes[$1].typespe);
											settype($3,nodes[$1].typespe);
											int iden=nodes[$3].child1;
											int of=nodes[iden].otherlistrefer;
											iddec[of].type=nodes[$1].typespe;
											nodes[$$].asscode=nodes[$1].asscode+nodes[$3].asscode;
										}
			;
initdeclarator	:identifier {
								$$=insert("initdeclarator",$1,-1,-1);
								//$$=$1;
								if (!finddeclar($1))
								{
									cout<<"re define at "<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<idlist[nodes[$1].otherlistrefer]<<endl;
								}
								
								
							}
				|identifier EQ expr {$$=insert("initdeclaratorwitha",$1,$3,-1);
										if (!finddeclar($1))
										{
											cout<<"re define at "<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<idlist[nodes[$1].otherlistrefer]<<endl;
										}
										//cout<<@1.first_line<<'\t'<<@1.first_column<<endl;
									struct node *t=&nodes[$$];
									t->otherlistrefer=nodes[$1].otherlistrefer;
									t->asscode=format("{0}{1}mov eax,_t{3}\nmov _t{2},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,finddeclar(nodes[$1].otherlistrefer)
									,nodes[$3].otherlistrefer);
									}
				;
typespecifermore:typespecifer LMB expr RMB	{$$=insert("type[]",$1,$3,-1);}
				|typespecifer {//$$=insert("type",$1,-1,-1);
								$$=$1;}
				;
typespecifer 	:INT {$$=insert("INT",-1,-1,-1);}
				|CHAR{$$=insert("CHAR",-1,-1,-1);}
				|BOOL{$$=insert("BOOL",-1,-1,-1);}
				;
exprlist:expr 
		|exprlist COMN expr
		;

expr	:expr PLUS expr		{$$=insert("+",$1,$3,-1);
								if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"+ must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								doubleexpcode($$,$1,$3,"add");
  			  					
  			  					

							}
		|expr MINUS expr	{$$=insert("-",$1,$3,-1);
								if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"- must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								doubleexpcode($$,$1,$3,"sub");

							}
		|expr DIV expr		{$$=insert("/",$1,$3,-1);
								if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"/ must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov edx,0\nmov eax,_t{2}\nmov ebx,_t{3}\nidiv ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);
							}
		|expr MULT expr     {$$=insert("*",$1,$3,-1);
								if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"* must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\nimul ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);

							}
		|unaryexpr EQ expr		{$$=insert("=",$1,$3,-1);
									if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<"= must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
									struct node *t=&nodes[$$];
									t->otherlistrefer=nodes[$1].otherlistrefer;
									t->asscode=format("{0}{1}mov eax,_t{3}\nmov _t{2},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									);
								}


			
		|expr LOGOR  expr		{$$=insert("||",$1,$3,-1);
									if(doubleboolcheck($1,$3))
								{
									settype($$,"BOOL");

								}
								else
								{
									cout<<"|| must be an operator with two bool"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\nor eax,ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);
									}
		|expr LOGAND  expr		{$$=insert("&&",$1,$3,-1);
										if(doubleboolcheck($1,$3))
								{
									settype($$,"BOOL");

								}
								else
								{
									cout<<"&& must be an operator with two bool"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\nand eax,ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);
							}
		|expr BITOR  expr		{$$=insert("|",$1,$3,-1);
								if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"| must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\nor eax,ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);
							}
		|expr BITXOR  expr		{$$=insert("^",$1,$3,-1);
									if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"^ must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\nxor eax,ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);
							}
		|expr BITAND  expr		{$$=insert("&",$1,$3,-1);
									if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"& must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\nand eax,ebx\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);
							}
		|expr NOTEQL  expr		{$$=insert("!=",$1,$3,-1);

									if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<"!= must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
									struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\ncmp eax,ebx\njne L{5}\nmov eax,0\njmp L{6}\nL{5}:\nmov eax,1\nL{6}:\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									,label++
									);
								}
		|expr EQL  expr		{$$=insert("==",$1,$3,-1);
								if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<"== must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\ncmp eax,ebx\nje L{5}\nmov eax,0\njmp L{6}\nL{5}:\nmov eax,1\nL{6}:\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									,label++
									);
								
								}
		|expr BEQ  expr		{$$=insert(">=",$1,$3,-1);
	if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<">= must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
										struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\ncmp eax,ebx\njge L{5}\nmov eax,0\njmp L{6}\nL{5}:\nmov eax,1\nL{6}:\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									,label++
									);
								
								}

		|expr SEQ  expr		{$$=insert("<=",$1,$3,-1);
	if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<"<= must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
										struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\ncmp eax,ebx\njle L{5}\nmov eax,0\njmp L{6}\nL{5}:\nmov eax,1\nL{6}:\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									,label++
									);
								
								}
		|expr BE  expr		{$$=insert(">",$1,$3,-1);
	if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<"> must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
										struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\ncmp eax,ebx\njg L{5}\nmov eax,0\njmp L{6}\nL{5}:\nmov eax,1\nL{6}:\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									,label++
									);
								
								}
		|expr SE  expr		{$$=insert("<",$1,$3,-1);
	if (nodes[$1].typespe==nodes[$3].typespe)
									{
										/* code */
										settype($$,nodes[$1].typespe);
									}
									else{
										cout<<"< must be an operator with two same parametor"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
			
									}
										struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ebx,_t{3}\ncmp eax,ebx\njl L{5}\nmov eax,0\njmp L{6}\nL{5}:\nmov eax,1\nL{6}:\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									,label++
									);
								
								}
		|expr LSHIFT  expr		{$$=insert("<<",$1,$3,-1);
		if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"<< must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ecx,_t{3}\nL{5}:\nshl eax,1\nloop L{5}\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									);
							}
		|expr RSHIFT  expr		{$$=insert(">>",$1,$3,-1);
		if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<">> must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
								struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov eax,_t{2}\nmov ecx,_t{3}\nL{5}:\nshr eax,1\nloop L{5}\nmov _t{4},eax\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									,label++
									);


							}
		|expr PER expr		{$$=insert("\%",$1,$3,-1);
								if(doubleintcheck($1,$3))
								{
									settype($$,"INT");

								}
								else
								{
									cout<<"\% must be an operator with two int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;
								}
									struct node *t=&nodes[$$];
								struct ident id={"INT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("{0}{1}mov edx,0\nmov eax,_t{2}\nmov ebx,_t{3}\nidiv ebx\nmov _t{4},edx\n"
									,nodes[$1].asscode
									,nodes[$3].asscode
									,nodes[$1].otherlistrefer
									,nodes[$3].otherlistrefer
									,nodes[$$].otherlistrefer
									);

							}
		|MINUS baseexpr	{$$=insert("-p",$2,-1,-1);
									if (checktype($2,"INT"))
									{
										/* code */
										settype($$,"INT");
									}
									else
									{
										cout<<"-s must be an operator with int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;

									}
									struct node *t=&nodes[$$];
									struct ident id={"CINT",nodes[$$].otherlistrefer};
									iddec.push_back(id);
									t->otherlistrefer=iddec.size()-1;
									t->asscode=format("mov eax,_t{0}\nmov ebx,0\nsub ebx,eax\nmov _t{1},ebx\n"
										,nodes[$2].otherlistrefer
										,nodes[$$].otherlistrefer
										);
								}
		|unaryexpr 			{//$$=insert("uexr",$1,-1,-1);
								$$=$1;}
		;    
unaryexpr	:postfixexpr	{//$$=insert("unaryexpr",$1,-1,-1);
								$$=$1;
								}
			| PLUPLU  unaryexpr {$$=insert("++p",$2,-1,-1);
									if (checktype($2,"INT"))
									{
										/* code */
										settype($$,"INT");
									}
									else
									{
										cout<<"++s must be an operator with int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;

									}
									struct node *t=&nodes[$$];
									struct ident id={"CINT",nodes[$$].otherlistrefer};
									iddec.push_back(id);
									t->otherlistrefer=iddec.size()-1;
									t->asscode=format("mov eax,_t{0}\ninc eax\nmov _t{1},eax\nmov _t{0},eax\n"
										,nodes[$2].otherlistrefer
										,nodes[$$].otherlistrefer
										);
								}
			|MINMIN unaryexpr	{$$=insert("--p",$2,-1,-1);
									if (checktype($2,"INT"))
									{
										/* code */
										settype($$,"INT");
									}
									else
									{
										cout<<"--s must be an operator with int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;

									}
									struct node *t=&nodes[$$];
									struct ident id={"CINT",nodes[$$].otherlistrefer};
									iddec.push_back(id);
									t->otherlistrefer=iddec.size()-1;
									t->asscode=format("mov eax,_t{0}\ndec eax\nmov _t{1},eax\nmov _t{0},eax\n"
										,nodes[$2].otherlistrefer
										,nodes[$$].otherlistrefer
										);
								}
			
			;
postfixexpr :postfixexpr LMB expr RMB	{$$=insert("post[]",$1,$3,-1);}
			|postfixexpr PLUPLU {$$=insert("pos++",$1,-1,-1);
				if (checktype($1,"INT"))
									{
										/* code */
										settype($$,"INT");
									}
									else
									{
										cout<<"s++ must be an operator with int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;

									}
									struct node *t=&nodes[$$];
									struct ident id={"CINT",nodes[$$].otherlistrefer};
									iddec.push_back(id);
									t->otherlistrefer=iddec.size()-1;
									t->asscode=format("mov eax,_t{0}\nmov _t{1},eax\ninc eax\nmov _t{0},eax\n"
										,nodes[$1].otherlistrefer
										,nodes[$$].otherlistrefer
										);


								}
			|postfixexpr MINMIN {$$=insert("pos--",$1,-1,-1);
								if (checktype($1,"INT"))
									{
										/* code */
										settype($$,"INT");
									}
									else
									{
										cout<<"s-- must be an operator with int"<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<endl;

									}
									struct node *t=&nodes[$$];
									struct ident id={"CINT",nodes[$$].otherlistrefer};
									iddec.push_back(id);
									t->otherlistrefer=iddec.size()-1;
									t->asscode=format("mov eax,_t{0}\nmov _t{1},eax\ndec eax\nmov _t{0},eax\n"
										,nodes[$1].otherlistrefer
										,nodes[$$].otherlistrefer
										);
								}

			|baseexpr	{//$$=insert("pos",$1,-1,-1);
							$$=$1;
							settype($$,nodes[$1].typespe);}
			;
baseexpr 	:NUMBER 			{	//cout<<"s"<<endl;
								string tmp=yylval.val;

								constlist.push_back(tmp);
								int lo=constlist.size()-1;
								$$=insert("N",-1,-1,-1,-1,-1);
								settype($$,"N");
								cout<<"1"<<endl;
								struct node *t=&nodes[$$];
								struct ident id={"CINT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("mov eax,{0}\nmov _t{1},eax\n",tmp,nodes[$$].otherlistrefer);

							}
			|CHARCONST			{ string tmp=yylval.val;
									cout<<"SS"<<endl;
									rconstcharlist.push_back(tmp);
									int qs=tmp[0];


									int lo=rconstcharlist.size()-1;
									$$=insert("C",-1,-1,-1,-1,-1);
									settype($$,"C");
									struct node *t=&nodes[$$];
									struct ident id={"Cchar",nodes[$$].otherlistrefer};
									iddec.push_back(id);
									t->otherlistrefer=iddec.size()-1;
									t->asscode=format("mov eax,{0}\nmov _t{1},eax\n",qs,nodes[$$].otherlistrefer);




								}

			|identifier {
							$$=$1;
							int dec=-1;
							dec=finddeclar(nodes[$1].otherlistrefer);
							if (dec==-1)
							{
								/* code */
								cout<<"not dec at "<<@1.first_line<<":"<<@1.first_column<<"~"<<@1.last_column<<" "<<idlist[nodes[$1].otherlistrefer]<<endl;

							}
							else
							{
								settype($1,iddec[dec].type);
								//iddec[dec].type

							}
							nodes[$$].otherlistrefer=dec;
							outprintint=dec;
								/*struct node *t=&nodes[$$];
								struct ident id={"CINT",nodes[$$].otherlistrefer};
								iddec.push_back(id);
								t->otherlistrefer=iddec.size()-1;
								t->asscode=format("mov eax,_t{0}\nmov _t{1},eax\n",dec,nodes[$$].otherlistrefer);
*/
						}
			|LB expr RB 		{$$=$2;}
			|TRUE 				{$$=insert("boolt",-1,-1,-1);}
			|FALSE 				{$$=insert("boolf",-1,-1,-1);}
			;
identifier:ID 				{	
								//showtree();
								string tmp=yylval.val;
								int lo=findID(tmp);

								if (lo==-1)
								{		
									idlist.push_back(tmp);
									lo=idlist.size()-1;

								}
								$$=insert(tmp,-1,-1,-1,-1,lo);

								trydecid($$);
							}

%%

int main() {
	cerr<<"rrr"<<endl;
	char* filename;
	cerr<<"f"<<endl;
	//cin>>filename;
	cerr<<"f"<<endl;
 /*if (strlen(filename)>5)
    {
    	
    	cerr<<"ss"<<endl;
    	yyin = fopen(filename,"r");

    }
    else
    {
    	yyin=fopen("1.txt","r");
    	cerr<<"s"<<endl;
    }
   */
    yyin=fopen("1.txt","r");
    //yylineno=1;
    cerr<<"rsr"<<endl;
    //cout<<filename<<endl;
    //vector<int> a;
    //rconstcharlist.push_back("beg");
  char buffer [100]={0};
  char buffers [10]={0};
  char buffert[10]="as";
  

	int i, j, n, r, x, y, pi = 10; char c = 'a';
	cout<<i<<endl;
	printf("%d\n",1+2-3*4/5%6&7|8^9>>1);
	for (i = 0; i < 10; i = i + 1) printf("%d\n",c++ - 'a');



  //const char* r;
  //sprintf(r,"rrr%s rsr");
  //printf("%s\n", r);
  

   // a.push_back(1);
    //cout<<a[0]<<endl;
	//do { 
	yyparse();
		//cout<<"rsr"<<endl;
	//} while(!feof(yyin));
	//cout<<"treelistasfollow"<<endl;showtree();
	string sq="rrr";
	string s=format("move{0}\n",sq);

	int head=findhead();
	showtreeshift("",head);
	cout<<endl<<"idlistasfollow"<<endl;showvec(idlist);
	cout<<endl<<"constlistasfollow"<<endl;showvec(constlist);
	cout<<endl<<"constcharasfollow"<<endl;showvec(rconstcharlist);
	cout<<endl<<"iddecasfollow"<<endl;showiddec();
	cout<<s<<endl;
	string endstr="";
	cout<<nodes[head].asscode<<endl;
	for (int i = 0; i < iddec.size(); ++i)
	{
		/* code */
		endstr=format("{1}_t{0} dd ?\n",i,endstr);
	}
	cout<<endstr<<endl;
	string header=".386 \n.Model Flat,StdCall \nOption CaseMap:None \ninclude .\\masm32\\include\\msvcrt.inc \nincludelib .\\masm32\\LIB\\msvcrt.lib \ninclude .\\masm32\\include\\masm32.inc \ninclude .\\masm32\\include\\kernel32.inc \ninclude .\\masm32\\macros\\macros.asm \nincludelib .\\masm32\\lib\\masm32.lib \nincludelib .\\masm32\\lib\\kernel32.lib \n.data \n";
	string all=header+endstr+"szInput db '%d',0\nszoutput db '%d',0ah,0dh\n.code\nstart:\n"+nodes[head].asscode+"exit\nend start\n";


	cout<<header<<endl;
	cout<<all<<endl;
	ofstream out("./gccandass/ccode.asm");
	out<<all;
	cout<<outprintint<<endl;
	return 0;

}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
