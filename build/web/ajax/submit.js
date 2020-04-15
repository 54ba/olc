$('form#ajax').on('submit',function(e){
	e.preventDefault();

var res={
	loader:$('<div /> ',{class:'loader'}),
	container:$('#ajax'),
	result:$('#result')
};
	var that =$(this),
	url = that.attr('action'),
	type=that.attr('method'),
	data={};

	that.find('[name]').each(function(){
	var that =$(this),
	name=that.attr('name'),
	value=that.val();
	data[name]=value;
	});

	$.ajax({
		url:url,
		type:type,
		data:data,
		beforeSend:function(){
			res.container.append(res.loader);
		},
		success:function(response){
			res.container.find(res.loader).remove();
			res.result.empty();
			res.result.append(response);
			console.log(response);

		}
	});



});