package com.sabpaisa.qforms.beans;

public class SampleFormView implements Comparable<SampleFormView>{

	   private String label;
	    private String value;
	    private Integer order;

	    public String getLabel() {
	        return this.label;
	    }

	    public void setLabel(String label) {
	        this.label = label;
	    }

	    public String getValue() {
	        return this.value;
	    }

	    public void setValue(String value) {
	        this.value = value;
	    }

	    public Integer getOrder() {
	        return this.order;
	    }

	    public void setOrder(Integer order) {
	        this.order = order;
	    }

	    @Override
	    public int compareTo(SampleFormView o) {
	        int compareorder = o.getOrder();
	        return this.order - compareorder;
	    }

		@Override
		public String toString() {
			return "SampleFormView [label=" + label + ", value=" + value + ", order=" + order + "]";
		}
	    
}
