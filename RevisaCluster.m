function mayor = RevisaCluster(robots,N,robot_actual)
%Funcion encargada de revisar la distribucion de clusters formados

    format long
    mayor = 0;
    clusters=ConteoClusters(robots,N);
    for i=1:N
        if robots(robot_actual).clase < clusters(i)
            mayor = 1;
        end
    end
    
end