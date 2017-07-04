classdef ReLU < dagnn.ElementWise
  properties
    useShortCircuit = true
    opts = {}
  end

  methods
    function outputs = forward(obj, inputs, params)
      outputs{1} = vl_nnrelu(inputs{1}, [], obj.opts{:}) ;
    end

    function [derInputs, derParams] = backward(obj, inputs, params, derOutputs)
      derInputs{1} = vl_nnrelu(inputs{1}, derOutputs{1}, obj.opts{:}) ;
      derParams = {} ;
    end

    function forwardAdvanced(obj, layer)
      if ~obj.useShortCircuit || ~obj.net.conserveMemory
        forwardAdvanced@dagnn.Layer(obj, layer) ;
        return ;
      end
      net = obj.net ;
      in = layer.inputIndexes ;
      out = layer.outputIndexes ;
      net.vars(out).value = vl_nnrelu(net.vars(in).value, [], obj.opts{:}) ;
      if ~net.vars(in).precious
        net.vars(in).value = [] ;
      end
    end

    function backwardAdvanced(obj, layer)
      if ~obj.useShortCircuit || ~obj.net.conserveMemory
        backwardAdvanced@dagnn.Layer(obj, layer) ;
        return ;
      end
      net = obj.net ;
      in = layer.inputIndexes ;
      out = layer.outputIndexes ;

      if isempty(net.vars(out).der), return ; end

      derInput = vl_nnrelu(net.vars(out).value, net.vars(out).der, obj.opts{:}) ;

      if ~net.vars(out).precious
        net.vars(out).der = [] ;
        net.vars(out).value = [] ;
      end

      if net.numPendingVarRefs(in) == 0
          net.vars(in).der = derInput ;
      else
          net.vars(in).der = net.vars(in).der + derInputs ;
      end
      net.numPendingVarRefs(in) = net.numPendingVarRefs(in) + 1 ;
    end

    function obj = ReLU(varargin)
      obj.load(varargin) ;
    end
  end
end
