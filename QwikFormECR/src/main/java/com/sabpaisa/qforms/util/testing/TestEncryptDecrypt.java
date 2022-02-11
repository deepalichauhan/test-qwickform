package com.sabpaisa.qforms.util.testing;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.requestprocessing.Encryptor;

public class TestEncryptDecrypt {


	
	private static Logger log = LogManager.getLogger(TestEncryptDecrypt.class.getName());

	public static void main(String[] args) {
		String authKey = "";
		String authIV  = "";
		String stringForEncryption="";
		String stringForDeycryption="";
		String query = "";
		
		//authKey="MSHIdmuQcC2jaFkr";
		//authIV="nWzfSXsi7gQVwEjH";
		
		//authKey="g6pexu2HUsglbKIc"; //AGCUS
		//authIV="Lq1p11kCqFrAT7V5";  //AGCUS
		
		
		stringForDeycryption="zxl8BQjP3P+vYPUt3e7hpzv9QSOtdqFreCcs4aAn6ae7DjhGMpUlLireP+PpWHx4cMrAtjMiE7N5ttOxhQc+JvUXT6kfXOzeGjXOx80o2zGEkD1e0PnlEPXaatPngnQGo3lxmU1ilTfrgD4/YdU8ftf34W/KKs/9UQ7/vpsvSUradopHbNiT+3QgamNS+kgOrZy7N5u8lYxcpR3cEg9+RertgntLHplbzYowUMEKCyNmtXvhrJQax7oNv+MFq0LtTNivbX05bGzebWAoYMwPSVt2sKx9MSCKgnEC6upGUcDBU+nY6+6VvTY7o+pvyQr8w2Oq2r13xcE0JKdLvkaBUFJUNMAqfNkqptWGe0IQCBTcxmfENWwB1WpuQHD0AcLfxZVRf0haJWjzObooaOOFyS3nwRI5vC8NZG76yGyHtq8F9csg4s4a4Yomt2gs08y38OG+Ez0jk7SNpTFyIHg2escIfBfjgIQCJD9ah8fvt+86kdHCqIZ8p1s+Am+j8gQMA640GSNQ1GQvr8G+iRTLQ+wtIdgN7PaL+A1XMGjRzMcb9T6uMp3Wo9fYxU1TAdFMC047EYZAHFU9fWLl9zsye2nZhmEFmEGAB1RWdPsqpX1DYqC4l1Fc7L2FTEZVdKFZGY1/ltZ8BVHThfnILpuYmeTLO6k2FSAduj7eEIBsv4=";
		//stringForDeycryption="D55P4ZZr%2BXlmaHQF5MtXs7nLiBKS5YKNOrdXhEDXcexN5Ret4upXFhqvo%2FrjXJC0Kz54pC4tE5iTl5faZtlkbFxXjvDzv6RhvoDuOQQmFIc8xCnFbp9VoG%2FP8OnsqMaaD7PplqhQue5M8uC978qjG3pWvzJO5eApvtrg3MZuxNRlzJQRtKe38LK0TQ5R%2FdoiKoX37lpnG6hiZFuEAbD%2Bc9V%2BYYxqyUmHMhOhdDlVl7je3zJ3X%2BoW1dCFf2%2BZbfYd4fpOmRncntbvIp5fTtNZvqdKAjJPnD2oD8OYvKFGedOZnPcWxmX7i%2BaKEXPryGsVHsUqYwwDxRXydqQggCMj5FBH5PzORDIaSguUYnXegkahc0g4s9KUw6gi%2FF%2BNxjkW8rxA0W3rn%2BV%2BX2%2FF%2FGvHQeD3Py1US9q3XVayVrEpS4r3CnI9QwUSZ%2FzqVxSf8rtTjtMHbrLYKB8aba3dmQAlZbtofN2wRnD2G3ySovXEWTsTbovnNNTCngOY1nM0Cb2XuzfTgf8r%2FEMTsBIA3TY0jFycKg%2FWbaw1mdFO2VWFr7RbFUWBZD7JIRs%2BS8Z6SxaLI7eQCfPBH9hWVw4kd9Mr8BGV6SfMDagp%2BnAI%2B7opQlP2V%2Bk%2BivOnIc2MnH5opjT%2FvHk4F2JSyNxWvZDmMS5e9g%3D%3D&cliencode=HEP01";
		//stringForDeycryption="ZSsA9s0Nnk+7twHptlsxj7gTDjTaKvOWacjSMkwJYEbVsJNpYb4zhApeCPANwAZCxkv4pcfeuSnZrtBKVdBr+O1JwJgyaxFwQeae0q/V7iIfL/w52fzrcW9aXNJCWzyhfRuvYK9u1Sv7UlWX3cnFSFNVj6R2JXqeGTnHltyZ8b/dNRa8NDRTKFV8aqGaNfBYoH/E1kuc48go3LwawWzn8gDXu6aanIUWplk6/gZcguN3yXrM8lkY+8Ba4JO6vJt/NqZkTkbmZPklveEavnizC25L75aBSPu8mTLsQV6OUkMNTa0QtNDQLOGVuQoIwmnTvsIqFhTydCLNKx+4k1wgjbjpw4Cge+a06HpeDmUxUFD9NvjS0+Ty1sOuDDo1hc/lsZKbkZqXtGrHBD+rg9/tueTU4tLbanOVfzV3worUk1UyDvbe/IoS973L+YxhIS9fGZjzJHNOO9uwx4prab77DT487gAr5tqvWe8x1ZRlB7Abc1O8u+Z2Mp7Gy691L+w6pslTQOPZmx8J/jePADNn5m7Yb18m++o93p/dDXs0oDvUoh+Hrr2IcdzP1AMOQn7oHdxb0EO8Tbo277F+2AcpC0/DDJgDJP//oS97cDrmXl0=";
		
		authKey="aCvtV9jeNsRWdMGN"; //
		authIV="r4AK4Uu5zXuRux3x";  //
		//stringForDeycryption="H2e09qFHgtpAs8QzhNTMlKp+RbmcHpS1VKjs3HW/Y7nDHephAVh64j/zbSlUMUTxABnF/F6S0FVtRLROQUz/bW9wKsm1kmDhkxLTBnN0tiFpeYttSowXVXdCAiAvKl817Nk4RujK1eKFO8IFmQJn3h5BjcVDgX8UlpkfQQsn6sdMBUYEafLelrg2PesBSmnW1Luc3EDRfg8tpqUw9GGCXKg4s4R8UR2dvZF2gBjzSdqoVgEg08XsJyBcKlBAXYZTGEqMZZxN0p0cn6XFADPoZdZZ7RTGQE5qtFiWKgov66UbIblqbsvN9n009rf7sNW8TMt19SlHb/f3o8Ae3hQcnZ4nb+Fwzjea/E/0mft8dnWV/QRjNqdC9y+CEqi58GXzuU7vXHAJSs1c1xramtDY0xQvptUEbyaRBN4O2c3bpQcFFx1A7y0W5TsIhbNkcYYiMb5AtNawh7Qs/7o/00Jw7PhLBl7BpEl+TWAT6Y7hsxoDluSzlKmENSey8X8KUZgz";
		//stringForDeycryption="pD07j6wgLdf3v16R5a5jKTYICd%2BufuA/cfzm3FOz0wRidcXJ2PQ%2BYawgvnUA/wr6ToaA00B2ip862pSDznZsEaRAC4UxvMiM%2B0p6ZsPMLUeei/bcSN%2Br6/l72XL%2BRUQeGigloxzw3uxhZcc/WYOlVoiNjBgtEWi/OaL6lRxwsQnAarMuVDW%2BP/qYjg2encNfdQAxxB6UXZrqo7YeawCtARFhgM2lsnyXU1iVn0eAclbem97xszpy%2BjroBoZq9vu4xwKLsSTalykK1C1kg6bqN7/VANFje9B7iyAJSjEj4fmq39d7gaz4Ii5xixKKHmwmvZ1oyVnk6G1ukuY7E76ZezMplOl1iYKoAZGbs%2Bz8aZzrhntjXZT9zlx5sJPqTBFdpirjhZv77FrddACuF3zg2x0EHOxPf7f94VnvSUYmU5yP6U8MJ%2BKChET12SAojuRd6UrPCLR7P4962fesmq0FozGxqHhgMd6ztOJslJLYk%2B5XmYWZarB3suinVZ813V/OIhkjRZs77eVLGjIcDv53ZUj6J6QIRm0PrBrz48xNK5/ndh5iJMJ0xYFUfICrSMJfDfPGRLr5r9W11WNAdan1FYDxt9EhM69DdvVZHFr9LDRWqd10gDiCrdvOjQRYnN7j";
		//stringForDeycryption="c2fYFnHnrNdRxs0NLEVP9/2bEXEVoBpM8ycRpNzkzl6Zgtvo3vMZVAsuGCz+iBdHaOJzGBT00BqueOPHUOHnpvBghME9o3clpdgatPBHUiWL0FmNqsasOEEbsqa1Kk2Dcw4ul4MSjAdoRz/R6FdkqsgORLg4UB9V2+NCjhnOjUVGx7pmUveAQNPa8Q7fGPGcyJNjrFDk/xsF9AmVf8vodlrJ/yoGu9fI60PMnlYmj6LYwprCcZT+NJfMjNzqNueGH+Ab2LtMn4XarBsfyuP0enEoz/F0QVtg5yXFdCkRp/4blHz8CxGZupO1Z5MP/GP5Z4qSd0GA8+NE+2aXkc28wsO57jQmM2jN5z7UAAoz3Ijj/dLAKru1jzfjtsysZtjCKx+d8LU7Wq87c7/Gf/DyoLaRKAyNR5NH8EFYSUHgjD39L7vPB1bX9dKDYrEaDoJAS7iMBodLKcNHr8ZHnFAurz3CPcYXeww3utD32GCRc9gnm8Yj4E/GOPKCTkiizUYFdkD/2gDTHEwft6Y3UhWYQVg529+pHR1cop9EmYV/uhRwtMe+zkhLaUpPIVlU1nLB";
		
		    /*--------------------------*/
		query = stringForDeycryption;
		log.info("actual query found in response from SabPaisa >>>>>>  {"+query+"}");
		query = query.replaceAll("%2B", "+");
		//query = query.replaceAll(" ", "+");
		log.info("query After removing space >>>>>> {" +query+"}");
		
		
		String decText = null;
		try {
			log.info("Going to ecrypt response query ");
			decText = Encryptor.decrypt(authKey, authIV, query);
			
			log.info("query after decreption, decText :: " + decText);
		} catch (Exception e) {
			log.info(" Exception occoured while decreption, "+e);
			e.printStackTrace();
		}
		
	}


}
