% Rami Lameche

classdef (Sealed) ThorLabRotationalMount <  handle % handle class

    properties (Access = private) %Only accessible to the class methods
        InstrObj
        InstruID = '';
        Angles = [0,0,0,0,0,0]
        Path = 'C:\Users\file';
    end
    
    methods
        function obj = ThorLabRotationalMount()
        end
    end
    
    methods (Static)
        function obj = getInstance()
            persistent localObj
            if isempty(localObj) || ~isvalid(localObj)
                localObj = ThorLabRotationalMount;
            end
            obj = localObj;
        end
    end
    
    methods 
        function Load_Data(obj,i)
            data = dlmread([obj.Path,'\SavedAngles.txt']);
            obj.Rotate_POS(data(i),i)
        end
        function connect(obj)
            obj.InstrObj = [MotorTemplate()];
            obj.Go_to_Last_All();
            fprintf('Finished...\n');
        end
        
        function CloseConnectionClear (obj)
            try
                obj.Save_Data;
                for i = 1:numel(obj.InstrObj)
                obj.InstrObj(i).delete;
                end
            catch
                error('Could not close Optical Head Waveplates Rotator!\n')
            end
            disp('Optical head cross pol waveplates handle closed');
        end
        
        function Save_Data(obj)
            fprintf('Saving Current angles to local...\n');
            Data = [obj.Angles(1) obj.Angles(2) obj.Angles(3) obj.Angles(4) obj.Angles(5) obj.Angles(6)];
            dlmwrite([obj.Path,'\SavedAngles.txt'],Data,'delimiter','\t','precision',8);       
        end


        function Go_to_Last_All(obj)
            data = dlmread([obj.Path,'\SavedAngles.txt']);
            fprintf('Go back to the last position stored on PC disk...\n');
            for i = 1:numel(obj.InstrObj)
            obj.InstrObj(i).SetAbsMovePos(0,data(i));
            obj.InstrObj(i).MoveAbsolute(0,true);
            end
         end
        
        function angle = get_Angle(obj,i)
            angle = obj.InstrObj(i).GetPosition_Position(0);
        end

        function SetJogStepSize(obj, angle,i)
            obj.InstrObj(i).SetJogStepSize(0,angle);
        end

        function Rotate_POS(obj,angle,i)
        obj.Angles(i) = obj.get_Angle(i);
        obj.InstrObj(i).SetAbsMovePos(0,angle);
        obj.InstrObj(i).MoveAbsolute(0,true);
        end

        function Rotate_Relative(obj,angle,i)
        obj.Angles(i) = obj.get_Angle(i) + angle;
        obj.InstrObj(i).SetRelMoveDist(0,angle);
        obj.InstrObj(i).MoveRelative(0,true);

        end

    end
end