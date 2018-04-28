all:report
App:executable.exe

executable.exe:prog.o thread_function.o
	gcc -o executable.exe prog.o thread_function.o -lm -lpthread

prog.o:prog.c common.h
	gcc -c prog.c -o prog.o

thread_function.o:thread_function.c common.h
	gcc -c thread_function.c -o thread_function.o

runtest:executable.exe bashscript.sh params.txt
	./bashscript.sh

analyse:speedup.txt speedvar.txt mean.txt threaddata.txt

threaddata.txt: analyse.py runtest
	python analyse.py
mean.txt: analyse.py runtest
	python analyse.py
speedup.txt: analyse.py runtest
	python analyse.py
speedvar.txt: analyse.py runtest
	python analyse.py

plot: scatter1.eps scatter2.eps scatter3.eps scatter4.eps scatter5.eps mean.eps speedup_color.eps speedup_errorbar.eps

scatter1.eps: threaddata.txt scatter.p
	gnuplot scatter.p
scatter2.eps: threaddata.txt scatter.p
	gnuplot scatter.p
scatter3.eps: threaddata.txt scatter.p
	gnuplot scatter.p
scatter4.eps: threaddata.txt scatter.p
	gnuplot scatter.p
scatter5.eps: threaddata.txt scatter.p
	gnuplot scatter.p
mean.eps: mean.txt lineplot.p
	gnuplot lineplot.p
speedup_color.eps: speedup.txt plot_speedup.p
	gnuplot plot_speedup.p
speedup_errorbar.eps: speedvar.txt plot_speedup2.p
	gnuplot plot_speedup2.p

report:report.pdf

report.pdf: report.tex scatter1.eps scatter2.eps scatter3.eps scatter4.eps scatter5.eps mean.eps speedup_color.eps speedup_errorbar.eps
	pdflatex report.tex
clean:
	rm -f *.o executable.exe *.eps runtest mean.txt speedup.txt speedvar.txt threaddata.txt *.pdf report.log report.aux
