function thetha = BarridoFrecuencia(robot_referencia,robots,DELTA_ROTACION,ALFA_POTENCIAL,N,SIGMA_ROTACION,SIGMA_A_POTENCIAL)
%Funcion que realiza la rotacion y el calculo de un angulo en una
%frecuencia
    
    format long
    robots(robot_referencia).thethaIncerteza=robots(robot_referencia).thetha;
    giro=0;
    compx=zeros(N);
    compy=zeros(N);
    while giro<=(2*pi)
        k = 1;
        eta = [];
        phi = [];
        for frecuencia=1:N
            k = 1;
            eta = [];
            phi = [];
            for robot_lejano=1:N
                alfa = zeros(N);
 
                if robot_referencia ~= robot_lejano && robots(robot_lejano).clase >= frecuencia

                    alfa(frecuencia) = atan2(robots(robot_lejano).posicionRect.y-robots(robot_referencia).posicionRect.y,robots(robot_lejano).posicionRect.x-robots(robot_referencia).posicionRect.x);
                    if alfa(frecuencia) < 0
                        alfa(frecuencia) = alfa(frecuencia) + (2*pi);
                    end
                    eta(k)= LobuloCos(abs(alfa(frecuencia)-robots(robot_referencia).thetha));
                    phi(k) = Potencial([robots(robot_referencia).posicionRect.x,robots(robot_referencia).posicionRect.y],[robots(robot_lejano).posicionRect.x,robots(robot_lejano).posicionRect.y],robots(robot_lejano).constante_potencial,ALFA_POTENCIAL,[robots(robot_referencia).thetha,robots(robot_referencia).thetha],SIGMA_A_POTENCIAL);
                    k=k+1;
                end
            end
        
            potencialDireccional(frecuencia) = dot(eta,phi);
            compx(frecuencia) = ( potencialDireccional(frecuencia)*cos(robots(robot_referencia).thetha) )+compx(frecuencia);
            compy(frecuencia) = ( potencialDireccional(frecuencia)*sin(robots(robot_referencia).thetha) )+compy(frecuencia);
            robots(robot_referencia).thetha = robots(robot_referencia).thetha + normrnd(DELTA_ROTACION,SIGMA_ROTACION);
            robots(robot_referencia).thethaIncerteza = robots(robot_referencia).thethaIncerteza + normrnd(DELTA_ROTACION,SIGMA_ROTACION);
            if robots(robot_referencia).thetha > (2*pi)
                while robots(robot_referencia).thetha > (2*pi)
                    robots(robot_referencia).thetha = robots(robot_referencia).thetha-(2*pi);
                    robots(robot_referencia).thethaIncerteza = robots(robot_referencia).thethaIncerteza-(2*pi);
                end
            end
        end
        giro = giro + DELTA_ROTACION;
        
    end
    for i=1:N
        thetha(i) = atan2(compy(i),compx(i));
        if thetha(i) < 0
            while thetha(i) < 0
                thetha(i)=thetha(i)+(2*pi);
            end
        end
        if thetha(i) > (2*pi)
            while thetha(i) > (2*pi)
                thetha(i)=thetha(i)-(2*pi);
            end
        end
    end
    
end

