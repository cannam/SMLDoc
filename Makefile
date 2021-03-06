# Makefile for SMLDoc
# $Id: Makefile.in,v 1.21 2007/12/13 08:59:46 katsu Exp $

srcdir = .
builddir = .
top_srcdir = .
top_builddir = .

include ./commonrule

VPATH = .

TARGETS = smldoc

LEXFILES =  $(srcdir)/src/main/ML.lex \
            $(srcdir)/src/main/ParamPattern.lex \
            $(srcdir)/src/main/LinkFile.lex \
            $(srcdir)/src/main/smlnjcm/CM.lex
YACCFILES = $(srcdir)/src/main/ML.grm \
            $(srcdir)/src/main/ParamPattern.grm \
            $(srcdir)/src/main/LinkFile.grm \
            $(srcdir)/src/main/smlnjcm/CM.grm

GENSOURCES = $(LEXFILES:.lex=.lex.sml) \
	     $(YACCFILES:.grm=.grm.sml) \
	     $(YACCFILES:.grm=.grm.sig) \
	     $(YACCFILES:.grm=.grm.desc)

SOURCES = src/main/Utility.sml \
          src/main/PATH_UTILITY.sig \
          src/main/PathUtility.sml \
          src/main/ParserUtil.sml \
          src/main/DocumentGenerationParameter.sml \
          src/main/AST.sig \
          src/main/Ast.sml \
          src/main/TokenTable.sml \
          src/main/ASTUTIL.sig \
          src/main/AstUtil.sml \
          src/main/DocComment.sml \
          src/main/AnnotatedAst.sml \
          src/main/EASY_HTML_PARSER.sig \
          src/main/EasyHTMLParser.sml \
          src/main/PARSER.sig \
          src/main/Parser.sml \
          src/main/DEPENDENCY_GRAPH.sig \
          src/main/DependencyGraph.sml \
          src/main/DEPENDENCY_ANALYZER.sig \
          src/main/DependencyAnalyzer.sml \
          src/main/ENVSet.sml \
          src/main/ElaboratedAst.sml \
          src/main/ELABORATOR.sig \
          src/main/Elaborator.sml \
          src/main/LinkFile.sml \
          src/main/EXTERNALREF_LINKER.sig \
          src/main/ExternalRefLinker.sml \
          src/main/Linkage.sml \
          src/main/Binds.sml \
          src/main/SUMMARIZER.sig \
          src/main/Summarizer.sml \
          src/main/DOCUMENT_GENERATOR.sig \
          src/main/HTML/html-lib.cm \
          src/main/HTML/html-sig.sml \
          src/main/HTML/html.sml \
          src/main/HTML/make-html.sml \
          src/main/HTML/pr-html.sml \
          src/main/HTMLDocumentGenerator.sml \
          src/main/SMLDOC.sig \
          src/main/SMLDoc.sml \
          src/main/GET_OPT.sig \
          src/main/GetOpt.sml \
          src/main/smlnjcm/CMSemantic.sml \
          src/main/smlnjcm/SourcePath.sml \
          src/main/smlnjcm/FileID.sml \
          src/main/smlnjcm/CMFILE_PARSER.sig \
          src/main/smlnjcm/CMFileParser.sml \
          src/main/Main.sml \
          src/main/call-main.sml \
          $(GENSOURCES)

all: $(TARGETS)

install: $(TARGETS)
	$(INSTALL) -d -m 755 '$(DESTDIR)$(bindir)'
	$(MAKESML) -B '$(DESTDIR)$(bindir)' -H '$(DESTDIR)$(heapdir)' \
	           -i -o smldoc

clean:
	-rm -rf $(srcdir)/src/main/.cm $(srcdir)/src/main/CM
	-rm -rf $(srcdir)/src/main/HTML/.cm $(srcdir)/src/main/HTML/CM
	-rm -rf $(srcdir)/src/main/smlnjcm/.cm $(srcdir)/src/main/smlnjcm/CM
	-rm -f $(GENSOURCES)
	$(MAKESML) -r -o smldoc

smldoc: src/main/sources.cm $(SOURCES)
	$(MAKESML) -o $@ $(srcdir)/src/main/sources.cm

$(srcdir)/src/main/ML.lex.sml: src/main/ML.lex
	$(MLLEX) $(srcdir)/src/main/ML.lex
$(srcdir)/src/main/ParamPattern.lex.sml: src/main/ParamPattern.lex
	$(MLLEX) $(srcdir)/src/main/ParamPattern.lex
$(srcdir)/src/main/LinkFile.lex.sml: src/main/LinkFile.lex
	$(MLLEX) $(srcdir)/src/main/LinkFile.lex
$(srcdir)/src/main/smlnjcm/CM.lex.sml: src/main/smlnjcm/CM.lex
	$(MLLEX) $(srcdir)/src/main/smlnjcm/CM.lex

$(srcdir)/src/main/ML.grm.sml $(srcdir)/src/main/ML.grm.sig: src/main/ML.grm
	$(MLYACC) $(srcdir)/src/main/ML.grm
$(srcdir)/src/main/ParamPattern.grm.sml $(srcdir)/src/main/ParamPattern.grm.sig: src/main/ParamPattern.grm
	$(MLYACC) $(srcdir)/src/main/ParamPattern.grm
$(srcdir)/src/main/LinkFile.grm.sml $(srcdir)/src/main/LinkFile.grm.sig: src/main/LinkFile.grm
	$(MLYACC) $(srcdir)/src/main/LinkFile.grm
$(srcdir)/src/main/smlnjcm/CM.grm.sml $(srcdir)/src/main/smlnjcm/CM.grm.sig: src/main/smlnjcm/CM.grm
	$(MLYACC) $(srcdir)/src/main/smlnjcm/CM.grm

# Makefile.in ends here.
