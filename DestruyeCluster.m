function robots = DestruyeCluster(robots,N,robot_actual)
%Destruye un cluster
    
    if RevisaCluster(robots,N,robot_actual)
        robots(robot_actual).clustered = 0;
        robots(robot_actual).vecindad(l) = zeros(N);
        for i=1:N
            if robots(robot_actual).vecindad(i) == 1
                robots(i).vecindad(robot_actual) = 0;
            end
        end
    end
 
end

