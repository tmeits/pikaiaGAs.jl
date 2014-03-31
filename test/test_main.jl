#

using Base.Test
using TestFunctions
using Pikaia

a = rand(1 : 50)

@test sort(a) == a[Pikaia.rqsort(length(a), a, [1:50])]

@test Pikaia.setctl([100, 500, 7, .85, 0, .005, .0005, .25, 1, 1, 1, 0], 2)[1] == 5
@test Pikaia.setctl([100, 500, 7, .85, 7, .005, .0005, .25, 1, 1, 1, 0], 2)[1] == 5
@test Pikaia.setctl([100, 500, 7, .85, 2, .005, .0005, .25, 1, 1, 1, 0], 2)[1] == 0

ng = [1: 55*6]
@test length(Pikaia.encode(55, 6, rand(55), ng) ) == 330
@test Pikaia.encode(55, 6, rand(55), ng)  == ng
ng = [1: 55*6]
@test Pikaia.encode(55, 6, rand(55), ng)  !=  [1: 55*6]

@test Pikaia.mutate!(55,9, 0.85, [1 : 55*9], 1) != [1 : 55*9]

pop_ph=rand(50,850);
gn=Pikaia.encode!(50,6,pop_ph[:,1],[1:50*6]);
Pikaia.decode(50, 5, gn);

# number of output arguments
@test length(TestFunctions.rastriginsfcn([0., 0.])) == 1

# type of output
@test typeof(TestFunctions.rastriginsfcn([0., 0.])) == Float64

# result
@test TestFunctions.rastriginsfcn([0., 0.]) == 0.


@test TestFunctions.rastrigin([0.]) == 0.0
@test TestFunctions.rastrigin([0., 0.]) == 0.0
@test TestFunctions.rastrigin(rand(10)*0.0) == 0.0

 Pikaia.init_pop(TestFunctions.rastrigin,1,4)
 Pikaia.set_ctrl_default()
 Pikaia.select(4, Pikaia.init_pop(TestFunctions.rastrigin,1,4)[4],1.)

(ph,fitns,ifit,jfit)=Pikaia.init_pop(TestFunctions.rastrigin,1,4)
g1=[1:5]
Pikaia.encode!(1,5,ph[:,1],g1)

for ss=1:32 g1=[1:ss]; println(Pikaia.encode!(1,ss,ph[:,3],g1)) ;print("\n")end
